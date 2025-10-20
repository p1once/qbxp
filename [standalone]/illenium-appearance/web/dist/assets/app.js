const state = {
  visible: false,
  section: 'clothing',
  config: null,
  settings: null,
  appearance: null,
  componentSettings: {},
  componentData: {},
  propSettings: {},
  propData: {},
  locales: null,
  theme: null,
  filters: {
    query: '',
    categories: new Set(),
    sort: 'featured',
    favoritesOnly: false,
  },
  cart: [],
  cartTotals: {
    items: 0,
    cost: 0,
  },
  favorites: new Set(),
  storeCache: {
    items: [],
    type: null,
  },
  cartVisible: false,
};

const componentMap = new Map([
  [1, { key: 'mask', label: 'Mask', hasTexture: true, configKey: 'masks' }],
  [2, { key: 'hair', label: 'Hair', hasTexture: true }],
  [3, { key: 'arms', label: 'Arms', hasTexture: false, configKey: 'upperBody' }],
  [4, { key: 'pants', label: 'Pants', hasTexture: true, configKey: 'lowerBody' }],
  [5, { key: 'bags', label: 'Bag', hasTexture: true, configKey: 'bags' }],
  [6, { key: 'shoes', label: 'Shoes', hasTexture: true, configKey: 'shoes' }],
  [7, { key: 'chain', label: 'Chain', hasTexture: true, configKey: 'scarfAndChains' }],
  [8, { key: 'tshirt', label: 'T-Shirt', hasTexture: true, configKey: 'shirts' }],
  [9, { key: 'bproof', label: 'Bulletproof Vest', hasTexture: true, configKey: 'bodyArmor' }],
  [10, { key: 'decals', label: 'Decals', hasTexture: true, configKey: 'decals' }],
  [11, { key: 'torso', label: 'Torso', hasTexture: true, configKey: 'jackets' }],
]);

const propMap = new Map([
  [0, { key: 'helmet', label: 'Helmet', configKey: 'hats' }],
  [1, { key: 'glasses', label: 'Glasses', configKey: 'glasses' }],
  [2, { key: 'ears', label: 'Ear Accessories', configKey: 'ear' }],
  [6, { key: 'watches', label: 'Watches', configKey: 'watches' }],
  [7, { key: 'bracelets', label: 'Bracelets', configKey: 'bracelets' }],
]);

const itemRegistry = new Map();

const componentMeta = {
  mask: { category: 'Headwear', icon: '😷', tags: ['Head', 'Utility'] },
  arms: { category: 'Upper Body', icon: '🧥', tags: ['Upper', 'Layer'] },
  pants: { category: 'Lower Body', icon: '👖', tags: ['Lower'] },
  bags: { category: 'Accessories', icon: '🎒', tags: ['Utility'] },
  shoes: { category: 'Footwear', icon: '👟', tags: ['Footwear'] },
  chain: { category: 'Accessories', icon: '⛓️', tags: ['Jewelry'] },
  tshirt: { category: 'Upper Body', icon: '👕', tags: ['Upper'] },
  bproof: { category: 'Protective', icon: '🛡️', tags: ['Utility'] },
  decals: { category: 'Detailing', icon: '🎨', tags: ['Customization'] },
  torso: { category: 'Outerwear', icon: '🧥', tags: ['Upper', 'Layer'] },
};

const propMeta = {
  helmet: { category: 'Headwear', icon: '🪖', tags: ['Head'] },
  glasses: { category: 'Facewear', icon: '🕶️', tags: ['Head'] },
  ears: { category: 'Accessories', icon: '👂', tags: ['Jewelry'] },
  watches: { category: 'Accessories', icon: '⌚', tags: ['Jewelry'] },
  bracelets: { category: 'Accessories', icon: '📿', tags: ['Jewelry'] },
};

const sectionLabels = {
  clothing: 'Clothing',
  props: 'Accessories',
  appearance: 'Appearance',
};

function resetFilters() {
  state.filters.query = '';
  state.filters.sort = 'featured';
  state.filters.categories = new Set();
  state.filters.favoritesOnly = false;
}

function resolveMetaForItem(type, key) {
  if (type === 'component') {
    return componentMeta[key] || { category: 'Apparel', icon: '🧾', tags: [] };
  }
  if (type === 'prop') {
    return propMeta[key] || { category: 'Accessory', icon: '🧾', tags: [] };
  }
  return { category: 'General', icon: '🧾', tags: [] };
}

function computeBasePrice(type) {
  if (type === 'prop') {
    return 75;
  }
  if (type === 'appearance') {
    return 60;
  }
  return 100;
}

function resolvePrice(type, key) {
  const themePricing = state.theme?.pricing?.[type]?.[key] ?? state.theme?.pricing?.[`default_${type}`];
  const configPricing = state.config?.pricing?.[type]?.[key] ?? state.config?.pricing?.[`default_${type}`];
  const value = themePricing ?? configPricing;
  if (typeof value === 'number') {
    return value;
  }
  return computeBasePrice(type);
}

function formatCurrency(value) {
  const amount = Math.max(0, Math.round(value));
  return `$${amount.toLocaleString()}`;
}

function resetCart() {
  state.cart = [];
  state.cartTotals.items = 0;
  state.cartTotals.cost = 0;
  state.cartVisible = false;
  updateCheckoutButton();
  const cartPanel = document.getElementById('cart-panel');
  if (cartPanel) {
    cartPanel.innerHTML = '';
    cartPanel.classList.add('collapsed');
  }
  updateCartToggleButton();
}

function getCategoriesFromItems(items) {
  const categories = new Set();
  for (const item of items) {
    if (item.category) {
      categories.add(item.category);
    }
  }
  return Array.from(categories).sort((a, b) => a.localeCompare(b));
}

function resolveVariantLabel(variant) {
  const key = variant?.variantKey || '';
  if (!key) {
    return variant?.label || 'Variant';
  }
  switch (key) {
    case 'drawable':
      return 'Style';
    case 'texture':
      return 'Texture';
    case 'color':
      return 'Color';
    case 'secondColor':
      return 'Accent';
    case 'highlight':
      return 'Highlight';
    default:
      return capitalize(key);
  }
}

function serializeCart() {
  return state.cart.map((entry) => ({
    id: entry.id,
    label: entry.label,
    type: entry.type,
    price: entry.price,
    category: entry.category,
    variants: entry.variants,
  }));
}

function fetchNui(event, data = {}) {
  return fetch(`https://illenium-appearance/${event}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify(data),
  }).then((response) => {
    if (!response.ok) {
      throw new Error(`NUI fetch failed: ${event}`);
    }
    return response.text();
  }).then((text) => {
    try {
      return text.length ? JSON.parse(text) : null;
    } catch (err) {
      console.error('Failed to parse NUI response for', event, err);
      return null;
    }
  }).catch((err) => {
    console.error('NUI request error', event, err);
    return null;
  });
}

function showApp() {
  if (state.visible) return;
  state.visible = true;
  resetFilters();
  resetCart();
  state.cartVisible = false;
  document.body.classList.remove('compact-layout', 'peek-mode');
  const app = document.getElementById('appearance-app');
  if (app) {
    app.classList.remove('hidden');
    app.setAttribute('aria-hidden', 'false');
  }
  const peekToggle = document.getElementById('peek-toggle');
  if (peekToggle) {
    peekToggle.classList.remove('hidden');
    peekToggle.textContent = '👁 Character Peek';
    peekToggle.setAttribute('aria-pressed', 'false');
  }
  const compactToggle = document.getElementById('toggle-compact');
  if (compactToggle) {
    compactToggle.textContent = 'Compact View';
    compactToggle.setAttribute('aria-pressed', 'false');
  }
}

function hideApp() {
  state.visible = false;
  document.body.classList.remove('compact-layout', 'peek-mode');
  const app = document.getElementById('appearance-app');
  if (app) {
    app.classList.add('hidden');
    app.setAttribute('aria-hidden', 'true');
  }
  const peekToggle = document.getElementById('peek-toggle');
  if (peekToggle) {
    peekToggle.classList.add('hidden');
    peekToggle.setAttribute('aria-pressed', 'false');
  }
  const compactToggle = document.getElementById('toggle-compact');
  if (compactToggle) {
    compactToggle.setAttribute('aria-pressed', 'false');
    compactToggle.textContent = 'Compact View';
  }
  document.getElementById('clothemain').innerHTML = '';
  document.getElementById('panel-extra').innerHTML = '';
  document.getElementById('modalfunc').classList.add('hidden');
  document.getElementById('modalfunc').innerHTML = '';
  itemRegistry.clear();
  resetFilters();
  resetCart();
  state.storeCache.items = [];
  state.storeCache.type = null;
  state.cartVisible = false;
}

function toggleCompactMode() {
  const isCompact = document.body.classList.toggle('compact-layout');
  const button = document.getElementById('toggle-compact');
  if (button) {
    button.textContent = isCompact ? 'Expand View' : 'Compact View';
    button.setAttribute('aria-pressed', isCompact ? 'true' : 'false');
  }
}

function togglePeekMode() {
  const isActive = document.body.classList.toggle('peek-mode');
  const button = document.getElementById('peek-toggle');
  if (button) {
    button.textContent = isActive ? '↩ Return to Menu' : '👁 Character Peek';
    button.setAttribute('aria-pressed', isActive ? 'true' : 'false');
  }
  const app = document.getElementById('appearance-app');
  if (app) {
    app.setAttribute('aria-hidden', isActive ? 'true' : 'false');
  }
}

function syncMaps() {
  state.componentSettings = {};
  if (state.settings?.components) {
    for (const entry of state.settings.components) {
      state.componentSettings[entry.component_id] = entry;
    }
  }
  state.componentData = {};
  if (state.appearance?.components) {
    for (const entry of state.appearance.components) {
      state.componentData[entry.component_id] = entry;
    }
  }
  state.propSettings = {};
  if (state.settings?.props) {
    for (const entry of state.settings.props) {
      state.propSettings[entry.prop_id] = entry;
    }
  }
  state.propData = {};
  if (state.appearance?.props) {
    for (const entry of state.appearance.props) {
      state.propData[entry.prop_id] = entry;
    }
  }
}

function determineDefaultSection() {
  if (state.config?.components) return 'clothing';
  if (state.config?.props) return 'props';
  return 'appearance';
}

function parseNumber(value, step = 1) {
  const numeric = step < 1 ? parseFloat(value) : parseInt(value, 10);
  if (Number.isNaN(numeric)) {
    return 0;
  }
  return numeric;
}

function updateComponentArray(componentId, key, value) {
  if (!state.appearance?.components) return;
  const index = state.appearance.components.findIndex((c) => c.component_id === componentId);
  if (index !== -1) {
    state.appearance.components[index][key] = value;
  }
}

function updatePropArray(propId, key, value) {
  if (!state.appearance?.props) return;
  const index = state.appearance.props.findIndex((p) => p.prop_id === propId);
  if (index !== -1) {
    state.appearance.props[index][key] = value;
  }
}

function renderSection(section) {
  const previousSection = state.section;
  state.section = section;
  document.querySelectorAll('.nav-btn').forEach((btn) => {
    btn.classList.toggle('active', btn.dataset.section === section);
  });
  const titleTop = document.getElementById('section-title-top');
  const titleBottom = document.getElementById('section-title-bottom');
  if (section !== 'appearance') {
    document.getElementById('panel-extra').innerHTML = '';
  }
  if (section !== 'appearance' && previousSection !== section) {
    resetFilters();
  }
  titleTop.textContent = sectionLabels[section] || 'Appearance';
  switch (section) {
    case 'clothing':
      titleBottom.textContent = 'Adjust drawables and textures for clothing items';
      state.storeCache.items = buildClothingItems();
      state.storeCache.type = 'component';
      renderStore(state.storeCache.items, 'component');
      break;
    case 'props':
      titleBottom.textContent = 'Manage accessories and wearable props';
      state.storeCache.items = buildPropItems();
      state.storeCache.type = 'prop';
      renderStore(state.storeCache.items, 'prop');
      break;
    default:
      titleBottom.textContent = 'Fine tune hair, overlays and facial features';
      state.cartVisible = false;
      updateCartToggleButton();
      renderAppearanceItems(buildAppearanceItems());
      break;
  }
}

function buildClothingItems() {
  const items = [];
  if (!state.config?.components) {
    return items;
  }
  for (const [componentId, info] of componentMap.entries()) {
    if (info.configKey && state.config.componentConfig && !state.config.componentConfig[info.configKey]) {
      continue;
    }
    const settings = state.componentSettings[componentId];
    const data = state.componentData[componentId];
    if (!settings || !data) continue;

    if (componentId === 2) {
      // handled in appearance section
      continue;
    }

    const meta = resolveMetaForItem('component', info.key);
    const card = {
      id: `component-${componentId}`,
      label: info.label,
      icon: meta.icon,
      category: meta.category,
      tags: meta.tags,
      description: `Explore ${info.label.toLowerCase()} collections and textures`,
      price: resolvePrice('component', info.key),
      type: 'component',
      componentId,
      key: info.key,
      variants: [],
    };

    card.variants.push(createComponentItem(componentId, 'drawable', `${info.label} Style`, settings.drawable.min, settings.drawable.max, data.drawable));
    if (info.hasTexture && settings.texture) {
      card.variants.push(createComponentItem(componentId, 'texture', `${info.label} Texture`, settings.texture.min, settings.texture.max, data.texture));
    }

    items.push(card);
  }
  return items;
}

function createComponentItem(componentId, key, label, min, max, value) {
  const id = `${componentId}-${key}`;
  return {
    id,
    label,
    min,
    max,
    step: 1,
    value,
    icon: '👕',
    type: 'slider',
    parent: `component-${componentId}`,
    group: componentId,
    variantKey: key,
    action: (newValue) => {
      const component = state.componentData[componentId];
      if (!component) return;
      component[key] = newValue;
      updateComponentArray(componentId, key, newValue);
      fetchNui('appearance_change_component', component).then((updated) => {
        if (updated) {
          state.componentSettings[componentId] = updated;
          const targetKey = key === 'drawable' ? 'texture' : key;
          if (updated[targetKey]) {
          const otherItemId = `${componentId}-${targetKey}`;
          const otherItem = itemRegistry.get(otherItemId);
          if (otherItem) {
            if (updated[targetKey].max !== undefined) {
              otherItem.max = updated[targetKey].max;
              updateSliderBounds(otherItemId, updated[targetKey].min, updated[targetKey].max, otherItem.step);
              }
              const refreshedComponent = state.componentData[componentId];
              if (refreshedComponent) {
                otherItem.value = refreshedComponent[targetKey];
                updateSliderValue(otherItemId, refreshedComponent[targetKey]);
              }
            }
          }
        }
      });
    }
  };
}

function buildPropItems() {
  const items = [];
  if (!state.config?.props) {
    return items;
  }
  for (const [propId, info] of propMap.entries()) {
    if (info.configKey && state.config.propConfig && !state.config.propConfig[info.configKey]) {
      continue;
    }
    const settings = state.propSettings[propId];
    const data = state.propData[propId];
    if (!settings || !data) continue;

    const meta = resolveMetaForItem('prop', info.key);
    const card = {
      id: `prop-${propId}`,
      label: info.label,
      icon: meta.icon,
      category: meta.category,
      tags: meta.tags,
      description: `Curate ${info.label.toLowerCase()} styles to match your fit`,
      price: resolvePrice('prop', info.key),
      type: 'prop',
      propId,
      key: info.key,
      variants: [],
    };

    card.variants.push(createPropItem(propId, 'drawable', `${info.label} Style`, settings.drawable.min, settings.drawable.max, data.drawable));
    if (settings.texture) {
      card.variants.push(createPropItem(propId, 'texture', `${info.label} Texture`, settings.texture.min, settings.texture.max, data.texture));
    }

    items.push(card);
  }
  return items;
}

function createPropItem(propId, key, label, min, max, value) {
  const id = `prop-${propId}-${key}`;
  return {
    id,
    label,
    min,
    max,
    step: 1,
    value,
    icon: '🧢',
    type: 'slider',
    parent: `prop-${propId}`,
    group: propId,
    variantKey: key,
    action: (newValue) => {
      const prop = state.propData[propId];
      if (!prop) return;
      prop[key] = newValue;
      updatePropArray(propId, key, newValue);
      fetchNui('appearance_change_prop', prop).then((updated) => {
        if (updated) {
          state.propSettings[propId] = updated;
          const otherKey = key === 'drawable' ? 'texture' : key;
          if (updated[otherKey]) {
            const otherItemId = `prop-${propId}-${otherKey}`;
            const otherItem = itemRegistry.get(otherItemId);
            if (otherItem) {
              otherItem.max = updated[otherKey].max;
              updateSliderBounds(otherItemId, updated[otherKey].min, updated[otherKey].max, otherItem.step);
              const refreshedProp = state.propData[propId];
              if (refreshedProp) {
                otherItem.value = refreshedProp[otherKey];
                updateSliderValue(otherItemId, refreshedProp[otherKey]);
              }
            }
          }
        }
      });
    }
  };
}

function buildAppearanceItems() {
  const items = [];
  const extraPanel = document.getElementById('panel-extra');
  extraPanel.innerHTML = '';

  if (state.config?.shopType === 'clothing') {
    const barberNote = document.createElement('div');
    barberNote.className = 'barber-note';
    barberNote.innerHTML = '<h4>Barber Services</h4><p>Visit a barber to manage haircuts and beard styles. Clothing stores focus on outfits only.</p>';
    extraPanel.appendChild(barberNote);
  }

  if (state.config?.ped && state.settings?.ped?.model?.items) {
    const select = document.createElement('select');
    select.id = 'model-select';
    for (const model of state.settings.ped.model.items) {
      const option = document.createElement('option');
      option.value = model;
      option.textContent = model;
      if (state.appearance?.model === model) {
        option.selected = true;
      }
      select.appendChild(option);
    }
    const label = document.createElement('label');
    label.textContent = 'Player Model';
    label.className = 'panel-label';
    label.appendChild(select);
    extraPanel.appendChild(label);
    select.addEventListener('change', () => {
      const value = select.value;
      fetchNui('appearance_change_model', value).then((data) => {
        if (!data) return;
        state.settings = data.appearanceSettings;
        state.appearance = data.appearanceData;
        syncMaps();
        renderSection(state.section);
      });
    });
  }

  if (state.settings?.hair && state.appearance?.hair) {
    const hair = state.appearance.hair;
    const hairSettings = state.settings.hair;
    items.push(createHairItem('style', 'Hair Style', hair.style, hairSettings.style.min, hairSettings.style.max, 1));
    if (hairSettings.texture) {
      items.push(createHairItem('texture', 'Hair Texture', hair.texture, hairSettings.texture.min, hairSettings.texture.max, 1));
    }
    if (hairSettings.color?.items) {
      items.push(createHairItem('color', 'Hair Color', hair.color, 0, hairSettings.color.items.length - 1, 1));
    }
    if (hairSettings.highlight?.items) {
      items.push(createHairItem('highlight', 'Hair Highlight', hair.highlight, 0, hairSettings.highlight.items.length - 1, 1));
    }
  }

  if (state.config?.headBlend && state.appearance?.headBlend) {
    const blend = state.appearance.headBlend;
    const entries = [
      ['shapeFirst', 'Shape First', 0, 45, 1],
      ['shapeSecond', 'Shape Second', 0, 45, 1],
      ['shapeThird', 'Shape Third', 0, 45, 1],
      ['skinFirst', 'Skin First', 0, 45, 1],
      ['skinSecond', 'Skin Second', 0, 45, 1],
      ['skinThird', 'Skin Third', 0, 45, 1],
      ['shapeMix', 'Shape Mix', 0, 1, 0.1],
      ['skinMix', 'Skin Mix', 0, 1, 0.1],
      ['thirdMix', 'Third Mix', 0, 1, 0.1],
    ];
    for (const [key, label, min, max, step] of entries) {
      items.push(createHeadBlendItem(key, label, blend[key], min, max, step));
    }
  }

  if (state.config?.faceFeatures && state.appearance?.faceFeatures) {
    for (const [key, value] of Object.entries(state.appearance.faceFeatures)) {
      items.push(createFaceFeatureItem(key, value));
    }
  }

  if (state.config?.headOverlays && state.appearance?.headOverlays && state.settings?.headOverlays) {
    for (const [key, overlaySettings] of Object.entries(state.settings.headOverlays)) {
      const overlay = state.appearance.headOverlays[key];
      if (!overlay) continue;
      if (overlaySettings.style) {
        items.push(createHeadOverlayItem(key, 'style', `${capitalize(key)} Style`, overlay.style, overlaySettings.style.min, overlaySettings.style.max, 1));
      }
      if (overlaySettings.opacity) {
        items.push(createHeadOverlayItem(key, 'opacity', `${capitalize(key)} Opacity`, overlay.opacity, overlaySettings.opacity.min, overlaySettings.opacity.max, overlaySettings.opacity.factor || 0.1));
      }
      if (overlaySettings.color) {
        items.push(createHeadOverlayItem(key, 'color', `${capitalize(key)} Color`, overlay.color ?? 0, 0, overlaySettings.color.items.length - 1, 1));
      }
      if (overlaySettings.color && overlay.secondColor !== undefined) {
        items.push(createHeadOverlayItem(key, 'secondColor', `${capitalize(key)} Highlight`, overlay.secondColor ?? 0, 0, overlaySettings.color.items.length - 1, 1));
      }
    }
  }

  if (state.settings?.eyeColor !== undefined && state.appearance?.eyeColor !== undefined) {
    const eyeSettings = state.settings.eyeColor;
    items.push({
      id: 'eye-color',
      label: 'Eye Color',
      min: eyeSettings.min,
      max: eyeSettings.max,
      step: 1,
      value: state.appearance.eyeColor,
      icon: '👁️',
      action: (newValue) => {
        state.appearance.eyeColor = newValue;
        fetchNui('appearance_change_eye_color', newValue);
      },
    });
  }

  return items;
}

function createHairItem(key, label, value, min, max, step) {
  return {
    id: `hair-${key}`,
    label,
    min,
    max,
    step,
    value,
    icon: '💇',
    action: (newValue) => {
      state.appearance.hair[key] = newValue;
      fetchNui('appearance_change_hair', state.appearance.hair).then((hairSettings) => {
        if (hairSettings) {
          state.settings.hair = hairSettings;
          renderSection(state.section);
        }
      });
    },
  };
}

function createHeadBlendItem(key, label, value, min, max, step) {
  return {
    id: `headblend-${key}`,
    label,
    min,
    max,
    step,
    value,
    icon: '🧬',
    action: (newValue) => {
      state.appearance.headBlend[key] = newValue;
      fetchNui('appearance_change_head_blend', state.appearance.headBlend);
    },
  };
}

function createFaceFeatureItem(key, value) {
  return {
    id: `facefeature-${key}`,
    label: prettifyKey(key),
    min: -1,
    max: 1,
    step: 0.1,
    value,
    icon: '🙂',
    action: (newValue) => {
      state.appearance.faceFeatures[key] = newValue;
      fetchNui('appearance_change_face_feature', state.appearance.faceFeatures);
    },
  };
}

function createHeadOverlayItem(key, property, label, value, min, max, step) {
  return {
    id: `overlay-${key}-${property}`,
    label,
    min,
    max,
    step,
    value,
    icon: '🎨',
    action: (newValue) => {
      const overlay = state.appearance.headOverlays[key];
      if (!overlay) return;
      overlay[property] = newValue;
      fetchNui('appearance_change_head_overlay', state.appearance.headOverlays);
    },
  };
}

function prettifyKey(key) {
  return key
    .replace(/([A-Z])/g, ' $1')
    .replace(/^./, (str) => str.toUpperCase());
}

function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

function renderAppearanceItems(items) {
  const container = document.getElementById('clothemain');
  container.innerHTML = '';
  itemRegistry.clear();

  if (!items.length) {
    const empty = document.createElement('p');
    empty.className = 'empty';
    empty.textContent = 'No options available for this category.';
    container.appendChild(empty);
    return;
  }

  for (const item of items) {
    itemRegistry.set(item.id, item);
    const article = document.createElement('article');
    article.className = 'leaderboard__profile';
    article.dataset.itemId = item.id;

    const icon = document.createElement('div');
    icon.className = 'leaderboard__picture';
    icon.textContent = item.icon || '•';
    article.appendChild(icon);

    const label = document.createElement('span');
    label.className = 'leaderboard__name';
    label.textContent = item.label;
    article.appendChild(label);

    if (item.type === 'select') {
      const select = document.createElement('select');
      select.className = 'card-select';
      select.dataset.itemId = item.id;
      for (const optionValue of item.options) {
        const option = document.createElement('option');
        option.value = optionValue;
        option.textContent = optionValue;
        if (optionValue === item.value) {
          option.selected = true;
        }
        select.appendChild(option);
      }
      select.addEventListener('change', () => item.action(select.value));
      article.appendChild(select);
      container.appendChild(article);
      continue;
    }

    const slider = document.createElement('input');
    slider.type = 'range';
    slider.className = 'slider__input';
    slider.dataset.itemId = item.id;
    slider.min = item.min;
    slider.max = item.max;
    slider.step = item.step;
    slider.value = item.value;
    article.appendChild(slider);

    const input = document.createElement('input');
    input.type = 'number';
    input.className = 'indextext';
    input.dataset.itemId = item.id;
    input.min = item.min;
    input.max = item.max;
    input.step = item.step;
    input.value = item.value;
    article.appendChild(input);

    slider.addEventListener('input', handleRangeInput);
    input.addEventListener('change', handleNumberChange);

    container.appendChild(article);
  }
}

function filterStoreItems(items) {
  const query = state.filters.query.trim().toLowerCase();
  const activeCategories = state.filters.categories;
  const favoritesOnly = state.filters.favoritesOnly;

  const filtered = items.filter((item) => {
    const matchesCategory = !activeCategories.size || activeCategories.has(item.category);
    const matchesFavorites = !favoritesOnly || state.favorites.has(item.id);
    if (!matchesCategory || !matchesFavorites) {
      return false;
    }
    if (!query) {
      return true;
    }
    const haystack = [item.label, item.description, ...(item.tags || [])]
      .filter(Boolean)
      .map((entry) => entry.toLowerCase());
    return haystack.some((entry) => entry.includes(query));
  });

  switch (state.filters.sort) {
    case 'price-asc':
      filtered.sort((a, b) => a.price - b.price);
      break;
    case 'price-desc':
      filtered.sort((a, b) => b.price - a.price);
      break;
    case 'alpha':
      filtered.sort((a, b) => a.label.localeCompare(b.label));
      break;
    default:
      filtered.sort((a, b) => {
        const aFav = state.favorites.has(a.id) ? 1 : 0;
        const bFav = state.favorites.has(b.id) ? 1 : 0;
        if (aFav !== bFav) {
          return bFav - aFav;
        }
        return a.label.localeCompare(b.label);
      });
      break;
  }

  return filtered;
}

function renderStore(items, type) {
  const container = document.getElementById('clothemain');
  container.innerHTML = '';
  itemRegistry.clear();

  const layout = document.createElement('div');
  layout.className = 'store-layout';

  const controls = createStoreControls(items, type);
  layout.appendChild(controls);

  const body = document.createElement('div');
  body.className = 'store-body';

  const grid = document.createElement('div');
  grid.className = 'store-grid';

  const filteredItems = filterStoreItems(items);
  if (!filteredItems.length) {
    const empty = document.createElement('div');
    empty.className = 'store-empty';
    empty.innerHTML = '<h3>No styles found</h3><p>Adjust your filters or search for another item.</p>';
    grid.appendChild(empty);
  } else {
    for (const item of filteredItems) {
      const card = buildStoreCard(item);
      grid.appendChild(card);
    }
  }

  body.appendChild(grid);
  calculateCartTotals();
  const cartPanel = renderCartPanel();
  cartPanel.classList.toggle('collapsed', !state.cartVisible);
  body.appendChild(cartPanel);
  layout.appendChild(body);
  container.appendChild(layout);
  updateCheckoutButton();
  updateCartToggleButton();
}

function createStoreControls(items, type) {
  const controls = document.createElement('section');
  controls.className = 'store-controls';

  const searchWrapper = document.createElement('div');
  searchWrapper.className = 'store-search';
  const searchIcon = document.createElement('span');
  searchIcon.className = 'store-search__icon';
  searchIcon.textContent = '🔍';
  const searchInput = document.createElement('input');
  searchInput.type = 'search';
  searchInput.placeholder = type === 'prop' ? 'Search accessories...' : 'Search apparel...';
  searchInput.value = state.filters.query;
  searchInput.addEventListener('input', (event) => {
    state.filters.query = event.target.value;
    renderStore(state.storeCache.items, state.storeCache.type);
  });
  searchWrapper.appendChild(searchIcon);
  searchWrapper.appendChild(searchInput);

  const filterGroup = document.createElement('div');
  filterGroup.className = 'store-filters';
  const categories = getCategoriesFromItems(items);
  for (const category of categories) {
    const chip = document.createElement('button');
    chip.className = 'filter-chip';
    chip.textContent = category;
    chip.dataset.category = category;
    chip.classList.toggle('active', state.filters.categories.has(category));
    chip.addEventListener('click', () => {
      if (state.filters.categories.has(category)) {
        state.filters.categories.delete(category);
      } else {
        state.filters.categories.add(category);
      }
      renderStore(state.storeCache.items, state.storeCache.type);
    });
    filterGroup.appendChild(chip);
  }

  const favoritesToggle = document.createElement('button');
  favoritesToggle.className = 'filter-chip favorites';
  favoritesToggle.textContent = state.filters.favoritesOnly ? '★ Favorites' : '☆ Favorites';
  favoritesToggle.classList.toggle('active', state.filters.favoritesOnly);
  favoritesToggle.addEventListener('click', () => {
    state.filters.favoritesOnly = !state.filters.favoritesOnly;
    renderStore(state.storeCache.items, state.storeCache.type);
  });
  filterGroup.appendChild(favoritesToggle);

  const sortWrapper = document.createElement('div');
  sortWrapper.className = 'store-sort';
  const sortLabel = document.createElement('label');
  sortLabel.textContent = 'Sort By';
  const sortSelect = document.createElement('select');
  sortSelect.innerHTML = `
    <option value="featured">Featured</option>
    <option value="price-asc">Price: Low to High</option>
    <option value="price-desc">Price: High to Low</option>
    <option value="alpha">Alphabetical</option>
  `;
  sortSelect.value = state.filters.sort;
  sortSelect.addEventListener('change', () => {
    state.filters.sort = sortSelect.value;
    renderStore(state.storeCache.items, state.storeCache.type);
  });
  sortWrapper.appendChild(sortLabel);
  sortWrapper.appendChild(sortSelect);

  const resetButton = document.createElement('button');
  resetButton.className = 'store-reset';
  resetButton.textContent = 'Reset Filters';
  resetButton.addEventListener('click', () => {
    resetFilters();
    renderStore(state.storeCache.items, state.storeCache.type);
  });

  const resultInfo = document.createElement('div');
  resultInfo.className = 'store-results';
  const count = filterStoreItems(items).length;
  resultInfo.textContent = `${count} ${count === 1 ? 'style' : 'styles'} ready to try`;

  controls.appendChild(searchWrapper);
  controls.appendChild(filterGroup);
  controls.appendChild(sortWrapper);
  controls.appendChild(resetButton);
  controls.appendChild(resultInfo);

  return controls;
}

function buildStoreCard(item) {
  const card = document.createElement('article');
  card.className = 'store-card';
  card.dataset.itemId = item.id;

  const header = document.createElement('header');
  header.className = 'store-card__header';

  const icon = document.createElement('div');
  icon.className = 'store-card__icon';
  icon.textContent = item.icon || '•';
  header.appendChild(icon);

  const title = document.createElement('div');
  title.className = 'store-card__title';
  const heading = document.createElement('h3');
  heading.textContent = item.label;
  const category = document.createElement('span');
  category.className = 'store-card__category';
  category.textContent = item.category;
  title.appendChild(heading);
  title.appendChild(category);
  header.appendChild(title);

  const favoriteButton = document.createElement('button');
  favoriteButton.className = 'favorite-btn';
  favoriteButton.dataset.itemId = item.id;
  favoriteButton.textContent = isFavorite(item.id) ? '★' : '☆';
  favoriteButton.title = isFavorite(item.id) ? 'Remove from favorites' : 'Mark as favorite';
  favoriteButton.addEventListener('click', (event) => {
    event.stopPropagation();
    toggleFavorite(item.id, favoriteButton);
  });
  header.appendChild(favoriteButton);

  card.appendChild(header);

  if (item.description) {
    const description = document.createElement('p');
    description.className = 'store-card__description';
    description.textContent = item.description;
    card.appendChild(description);
  }

  const price = document.createElement('div');
  price.className = 'store-card__price';
  price.textContent = formatCurrency(item.price);
  card.appendChild(price);

  if (item.tags?.length) {
    const tagGroup = document.createElement('div');
    tagGroup.className = 'store-card__tags';
    for (const tag of item.tags) {
      const chip = document.createElement('span');
      chip.className = 'store-card__tag';
      chip.textContent = tag;
      tagGroup.appendChild(chip);
    }
    card.appendChild(tagGroup);
  }

  const variantsContainer = document.createElement('div');
  variantsContainer.className = 'store-card__variants';
  for (const variant of item.variants) {
    itemRegistry.set(variant.id, variant);
    const variantRow = document.createElement('div');
    variantRow.className = 'store-card__variant';

    const variantLabel = document.createElement('label');
    variantLabel.textContent = resolveVariantLabel(variant);
    variantLabel.htmlFor = `slider-${variant.id}`;
    variantRow.appendChild(variantLabel);

    const controls = document.createElement('div');
    controls.className = 'store-card__controls';

    const slider = document.createElement('input');
    slider.type = 'range';
    slider.className = 'slider__input';
    slider.dataset.itemId = variant.id;
    slider.id = `slider-${variant.id}`;
    slider.min = variant.min;
    slider.max = variant.max;
    slider.step = variant.step;
    slider.value = variant.value;
    controls.appendChild(slider);

    const numberInput = document.createElement('input');
    numberInput.type = 'number';
    numberInput.className = 'indextext';
    numberInput.dataset.itemId = variant.id;
    numberInput.min = variant.min;
    numberInput.max = variant.max;
    numberInput.step = variant.step;
    numberInput.value = variant.value;
    controls.appendChild(numberInput);

    slider.addEventListener('input', handleRangeInput);
    numberInput.addEventListener('change', handleNumberChange);

    variantRow.appendChild(controls);
    variantsContainer.appendChild(variantRow);
  }
  card.appendChild(variantsContainer);

  const summary = document.createElement('div');
  summary.className = 'store-card__summary';
  summary.textContent = buildVariantSummary(item);
  card.appendChild(summary);

  const actions = document.createElement('div');
  actions.className = 'store-card__actions';
  const addButton = document.createElement('button');
  addButton.className = 'store-card__action';
  addButton.dataset.itemId = item.id;
  if (isInCart(item.id)) {
    addButton.textContent = 'In Bag';
    addButton.classList.add('in-cart');
  } else {
    addButton.textContent = 'Add to Bag';
  }
  addButton.addEventListener('click', () => addToCart(item, addButton));
  actions.appendChild(addButton);
  card.appendChild(actions);

  return card;
}

function renderCartPanel() {
  const panel = document.createElement('aside');
  panel.id = 'cart-panel';
  panel.className = 'cart-panel';
  updateCartPanel(panel);
  return panel;
}

function calculateCartTotals() {
  let total = 0;
  for (const entry of state.cart) {
    total += entry.price;
  }
  state.cartTotals.items = state.cart.length;
  state.cartTotals.cost = total;
}

function updateCartPanel(target) {
  const panel = target || document.getElementById('cart-panel');
  if (!panel) return;

  panel.innerHTML = '';

  const header = document.createElement('header');
  header.className = 'cart-panel__header';
  const title = document.createElement('h3');
  title.textContent = 'Shopping Bag';
  const count = document.createElement('span');
  count.textContent = `${state.cartTotals.items} ${state.cartTotals.items === 1 ? 'item' : 'items'}`;
  header.appendChild(title);
  header.appendChild(count);
  panel.appendChild(header);

  if (!state.cart.length) {
    const empty = document.createElement('div');
    empty.className = 'cart-panel__empty';
    empty.innerHTML = '<p>Your bag is empty. Pin favorites or add styles to curate a look.</p>';
    panel.appendChild(empty);
  } else {
    const list = document.createElement('ul');
    list.className = 'cart-panel__list';
    for (const entry of state.cart) {
      const item = document.createElement('li');
      item.className = 'cart-panel__item';

      const info = document.createElement('div');
      info.className = 'cart-panel__details';
      const name = document.createElement('strong');
      name.textContent = `${entry.icon || '•'} ${entry.label}`;
      const meta = document.createElement('span');
      meta.textContent = entry.category;
      const variants = document.createElement('span');
      variants.className = 'cart-panel__variants';
      variants.textContent = entry.variants.map((variant) => `${variant.label} ${variant.value}`).join(' • ');
      info.appendChild(name);
      info.appendChild(meta);
      info.appendChild(variants);

      const actions = document.createElement('div');
      actions.className = 'cart-panel__meta';
      const price = document.createElement('span');
      price.className = 'cart-panel__price';
      price.textContent = formatCurrency(entry.price);
      const remove = document.createElement('button');
      remove.className = 'cart-panel__remove';
      remove.textContent = 'Remove';
      remove.addEventListener('click', () => removeFromCart(entry.id));
      actions.appendChild(price);
      actions.appendChild(remove);

      item.appendChild(info);
      item.appendChild(actions);
      list.appendChild(item);
    }
    panel.appendChild(list);
  }

  const footer = document.createElement('footer');
  footer.className = 'cart-panel__footer';
  const totalLabel = document.createElement('span');
  totalLabel.textContent = 'Estimated Total';
  const totalValue = document.createElement('span');
  totalValue.className = 'cart-panel__total';
  totalValue.textContent = formatCurrency(state.cartTotals.cost);
  footer.appendChild(totalLabel);
  footer.appendChild(totalValue);
  panel.appendChild(footer);
  panel.classList.toggle('collapsed', !state.cartVisible);
  updateCartToggleButton();
}

function isInCart(itemId) {
  return state.cart.some((entry) => entry.id === itemId);
}

function addToCart(item, button) {
  const entry = {
    id: item.id,
    label: item.label,
    icon: item.icon,
    category: item.category,
    price: item.price,
    type: item.type,
    variants: item.variants.map((variant) => ({
      id: variant.id,
      label: resolveVariantLabel(variant),
      value: variant.value,
    })),
  };

  const index = state.cart.findIndex((cartItem) => cartItem.id === item.id);
  if (index !== -1) {
    state.cart[index] = entry;
  } else {
    state.cart.push(entry);
  }

  calculateCartTotals();
  updateCartPanel();
  updateCheckoutButton();

  if (button) {
    button.textContent = 'In Bag';
    button.classList.add('in-cart');
  }
}

function removeFromCart(itemId) {
  const index = state.cart.findIndex((entry) => entry.id === itemId);
  if (index === -1) return;
  state.cart.splice(index, 1);
  calculateCartTotals();
  updateCartPanel();
  updateCheckoutButton();

  const button = document.querySelector(`.store-card__action[data-item-id="${itemId}"]`);
  if (button) {
    button.textContent = 'Add to Bag';
    button.classList.remove('in-cart');
  }

  if (state.filters.favoritesOnly && !state.favorites.has(itemId)) {
    renderStore(state.storeCache.items, state.storeCache.type);
  }
}

function isFavorite(itemId) {
  return state.favorites.has(itemId);
}

function toggleFavorite(itemId, button) {
  if (state.favorites.has(itemId)) {
    state.favorites.delete(itemId);
  } else {
    state.favorites.add(itemId);
  }

  updateFavoriteButtonState(itemId, button);

  if (state.filters.favoritesOnly) {
    renderStore(state.storeCache.items, state.storeCache.type);
  }
}

function updateFavoriteButtonState(itemId, button) {
  const targetButton = button || document.querySelector(`.favorite-btn[data-item-id="${itemId}"]`);
  if (!targetButton) return;
  const fav = state.favorites.has(itemId);
  targetButton.textContent = fav ? '★' : '☆';
  targetButton.title = fav ? 'Remove from favorites' : 'Mark as favorite';
  targetButton.classList.toggle('active', fav);
  const favoritesToggle = document.querySelector('.filter-chip.favorites');
  if (favoritesToggle) {
    favoritesToggle.textContent = state.filters.favoritesOnly ? '★ Favorites' : '☆ Favorites';
    favoritesToggle.classList.toggle('active', state.filters.favoritesOnly);
  }
}

function buildVariantSummary(item) {
  if (!item?.variants?.length) {
    return 'Preview this piece before adding it to your look.';
  }
  return item.variants
    .map((variant) => `${resolveVariantLabel(variant)} ${variant.value}`)
    .join(' • ');
}

function refreshVariantSummary(parentId) {
  if (!parentId) return;
  const summary = document.querySelector(`.store-card[data-item-id="${parentId}"] .store-card__summary`);
  if (!summary) return;
  const storeItem = state.storeCache.items.find((entry) => entry.id === parentId);
  if (!storeItem) return;
  summary.textContent = buildVariantSummary(storeItem);
}

function updateCheckoutButton() {
  const button = document.getElementById('save_clothe');
  if (!button) return;
  if (state.cartTotals.items > 0) {
    button.textContent = `Checkout ${formatCurrency(state.cartTotals.cost)}`;
    button.classList.add('has-cart');
  } else {
    button.textContent = 'Save Current';
    button.classList.remove('has-cart');
  }
}

function ensureCartPanelVisibility() {
  const panel = document.getElementById('cart-panel');
  if (panel) {
    panel.classList.toggle('collapsed', !state.cartVisible);
  }
}

function updateCartToggleButton() {
  const viewButton = document.getElementById('viewcart');
  if (viewButton) {
    viewButton.textContent = state.cartVisible ? 'Hide Cart' : 'View Cart';
  }
}

function toggleCartPanel(force) {
  if (state.section === 'appearance') {
    handleCartUpdate();
    return;
  }
  if (typeof force === 'boolean') {
    state.cartVisible = force;
  } else {
    state.cartVisible = !state.cartVisible;
  }
  ensureCartPanelVisibility();
  updateCartToggleButton();
}

function handleRangeInput(event) {
  const id = event.target.dataset.itemId;
  const item = itemRegistry.get(id);
  if (!item) return;
  const value = clamp(parseNumber(event.target.value, item.step), item.min, item.max);
  item.value = value;
  updateNumberValue(id, value);
  if (item.parent) {
    refreshVariantSummary(item.parent);
  }
  queueAction(item, value);
}

function handleNumberChange(event) {
  const id = event.target.dataset.itemId;
  const item = itemRegistry.get(id);
  if (!item) return;
  let value = clamp(parseNumber(event.target.value, item.step), item.min, item.max);
  event.target.value = value;
  item.value = value;
  updateSliderValue(id, value);
  if (item.parent) {
    refreshVariantSummary(item.parent);
  }
  queueAction(item, value);
}

function clamp(value, min, max) {
  return Math.min(Math.max(value, min), max);
}

function queueAction(item, value) {
  if (item.pending) {
    clearTimeout(item.pending);
  }
  item.pending = setTimeout(() => {
    item.pending = null;
    if (typeof item.action === 'function') {
      item.action(value);
    }
  }, 35);
}

function updateNumberValue(id, value) {
  const input = document.querySelector(`input.indextext[data-item-id="${id}"]`);
  if (input) {
    input.value = value;
  }
}

function updateSliderValue(id, value) {
  const slider = document.querySelector(`input.slider__input[data-item-id="${id}"]`);
  if (slider) {
    slider.value = value;
  }
}

function updateSliderBounds(id, min, max, step) {
  const slider = document.querySelector(`input.slider__input[data-item-id="${id}"]`);
  const input = document.querySelector(`input.indextext[data-item-id="${id}"]`);
  if (slider) {
    slider.min = min;
    slider.max = max;
    slider.step = step;
  }
  if (input) {
    input.min = min;
    input.max = max;
    input.step = step;
  }
}

async function initializeAppearance() {
  const [locales, settings, data, theme] = await Promise.all([
    fetchNui('appearance_get_locales'),
    fetchNui('appearance_get_settings'),
    fetchNui('appearance_get_data'),
    fetchNui('get_theme_configuration'),
  ]);

  state.locales = locales;
  state.settings = settings?.appearanceSettings || null;
  state.config = data?.config || null;
  state.appearance = data?.appearanceData || null;
  state.theme = theme || null;
  syncMaps();
  state.section = determineDefaultSection();
  updateNavVisibility();
  renderSection(state.section);
}

function updateNavVisibility() {
  const nav = document.getElementById('section-nav');
  nav.querySelectorAll('.nav-btn').forEach((button) => {
    const section = button.dataset.section;
    let enabled = true;
    if (section === 'clothing') {
      enabled = Boolean(state.config?.components);
    } else if (section === 'props') {
      enabled = Boolean(state.config?.props);
    } else if (section === 'appearance') {
      enabled = true;
    }
    button.disabled = !enabled;
    if (!enabled && button.classList.contains('active')) {
      button.classList.remove('active');
    }
  });
}

function handleNavClick(event) {
  const button = event.target.closest('.nav-btn');
  if (!button || button.disabled) return;
  renderSection(button.dataset.section);
}

function handleCameraClick(event) {
  const button = event.target.closest('.camera-btn');
  if (!button) return;
  const camera = button.dataset.camera;
  fetchNui('appearance_set_camera', camera);
}

function handleRotateClick(event) {
  const button = event.target.closest('.rotate-btn');
  if (!button) return;
  const direction = button.dataset.rotate;
  fetchNui('appearance_rotate_camera', direction);
}

function handleTurnClick() {
  fetchNui('appearance_turn_around');
}

function handleSave() {
  if (!state.appearance) return;
  const payload = {
    appearance: state.appearance,
    context: {
      section: state.section,
      shopType: state.config?.shopType || null,
    },
  };
  if (state.cartTotals.items > 0) {
    payload.cart = serializeCart();
    payload.cartTotal = state.cartTotals.cost;
  }
  fetchNui('appearance_save', payload);
}

function handleExit() {
  fetchNui('appearance_exit');
}

function handleCartUpdate() {
  state.cartVisible = true;
  updateCartToggleButton();
  renderSection('clothing');
}

function closeModal() {
  const modal = document.getElementById('modalfunc');
  if (!modal) return;
  modal.classList.add('hidden');
  modal.innerHTML = '';
}

function openRemoveClothesModal() {
  const modal = document.getElementById('modalfunc');
  if (!modal) return;
  modal.innerHTML = `
    <div class="modal__content">
      <h2 class="modal__title">Remove Clothes</h2>
      <p class="modal__description">Choose which wardrobe preset to clear.</p>
      <div class="modal__actions">
        <button data-remove="head">Head</button>
        <button data-remove="body">Body</button>
        <button data-remove="bottom">Bottom</button>
        <button class="danger" data-dismiss="true">Close</button>
      </div>
    </div>`;
  modal.classList.remove('hidden');
  modal.querySelectorAll('[data-remove]').forEach((button) => {
    button.addEventListener('click', (event) => {
      const type = event.currentTarget.dataset.remove;
      if (!type) return;
      fetchNui('appearance_remove_clothes', type);
      closeModal();
    });
  });
  const dismiss = modal.querySelector('[data-dismiss]');
  if (dismiss) {
    dismiss.addEventListener('click', closeModal);
  }
}

async function openOutfitModal() {
  const modal = document.getElementById('modalfunc');
  if (!modal) return;
  modal.innerHTML = `
    <div class="modal__content">
      <h2 class="modal__title">Saved Outfits</h2>
      <p class="modal__description">Gathering your saved looks...</p>
      <div class="modal__actions">
        <button data-dismiss="true">Close</button>
      </div>
    </div>`;
  modal.classList.remove('hidden');
  const dismiss = modal.querySelector('[data-dismiss]');
  if (dismiss) {
    dismiss.addEventListener('click', closeModal);
  }

  try {
    const outfits = await fetchNui('appearance_get_outfits');
    const description = modal.querySelector('.modal__description');
    if (!outfits || !outfits.length) {
      description.textContent = 'You do not have any saved outfits yet.';
      return;
    }

    description.textContent = 'Preview your stored outfits and pick one to apply instantly.';
    const list = document.createElement('ul');
    list.className = 'modal__list';

    outfits.forEach((outfit) => {
      const item = document.createElement('li');
      const info = document.createElement('div');
      info.className = 'modal__list-info';
      const title = document.createElement('strong');
      title.textContent = outfit.name || 'Outfit';
      const subtitle = document.createElement('span');
      subtitle.textContent = outfit.model || 'Current model';
      info.appendChild(title);
      info.appendChild(subtitle);

      const action = document.createElement('button');
      action.textContent = 'Wear';
      action.addEventListener('click', () => applyOutfit(outfit));

      item.appendChild(info);
      item.appendChild(action);
      list.appendChild(item);
    });

    const content = modal.querySelector('.modal__content');
    content.insertBefore(list, content.querySelector('.modal__actions'));
  } catch (error) {
    console.error('Failed to load outfits', error);
    const description = modal.querySelector('.modal__description');
    if (description) {
      description.textContent = 'Unable to load outfits right now. Please try again later.';
    }
  }
}

function applyOutfit(outfit) {
  if (!outfit) return;
  fetchNui('appearance_apply_outfit', outfit).then((result) => {
    if (result?.appearanceData) {
      state.appearance = result.appearanceData;
      syncMaps();
      renderSection(state.section);
    }
  });
  closeModal();
}

function setupEventListeners() {
  document.getElementById('section-nav').addEventListener('click', handleNavClick);
  document.querySelectorAll('.camera-btn').forEach((button) => button.addEventListener('click', handleCameraClick));
  document.querySelectorAll('.rotate-btn').forEach((button) => button.addEventListener('click', handleRotateClick));
  document.getElementById('btn-turn').addEventListener('click', handleTurnClick);
  document.getElementById('viewcart').addEventListener('click', () => toggleCartPanel());
  document.getElementById('addtocar').addEventListener('click', handleCartUpdate);
  document.getElementById('save_clothe').addEventListener('click', handleSave);
  document.getElementById('load_clothe').addEventListener('click', openOutfitModal);
  document.getElementById('remove_clothe').addEventListener('click', openRemoveClothesModal);
  document.getElementById('btn-exit').addEventListener('click', handleExit);
  const compactToggle = document.getElementById('toggle-compact');
  if (compactToggle) {
    compactToggle.addEventListener('click', toggleCompactMode);
  }
  const peekToggle = document.getElementById('peek-toggle');
  if (peekToggle) {
    peekToggle.addEventListener('click', togglePeekMode);
  }
  const modal = document.getElementById('modalfunc');
  if (modal) {
    modal.addEventListener('click', (event) => {
      if (event.target === modal) {
        closeModal();
      }
    });
  }
}

window.addEventListener('message', (event) => {
  const data = event.data;
  if (!data || !data.type) return;
  if (data.type === 'appearance_display') {
    showApp();
    initializeAppearance();
  } else if (data.type === 'appearance_hide') {
    hideApp();
  }
});

document.addEventListener('DOMContentLoaded', () => {
  setupEventListeners();
});
