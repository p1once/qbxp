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

const sectionLabels = {
  clothing: 'Clothing',
  props: 'Accessories',
  appearance: 'Appearance',
};

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
  document.getElementById('appearance-app').classList.remove('hidden');
}

function hideApp() {
  state.visible = false;
  document.getElementById('appearance-app').classList.add('hidden');
  document.getElementById('clothemain').innerHTML = '';
  document.getElementById('panel-extra').innerHTML = '';
  itemRegistry.clear();
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
  state.section = section;
  document.querySelectorAll('.nav-btn').forEach((btn) => {
    btn.classList.toggle('active', btn.dataset.section === section);
  });
  const titleTop = document.getElementById('section-title-top');
  const titleBottom = document.getElementById('section-title-bottom');
  if (section !== 'appearance') {
    document.getElementById('panel-extra').innerHTML = '';
  }
  titleTop.textContent = sectionLabels[section] || 'Appearance';
  switch (section) {
    case 'clothing':
      titleBottom.textContent = 'Adjust drawables and textures for clothing items';
      renderItems(buildClothingItems());
      break;
    case 'props':
      titleBottom.textContent = 'Manage accessories and wearable props';
      renderItems(buildPropItems());
      break;
    default:
      titleBottom.textContent = 'Fine tune hair, overlays and facial features';
      renderItems(buildAppearanceItems());
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

    items.push(createComponentItem(componentId, 'drawable', `${info.label} 1`, settings.drawable.min, settings.drawable.max, data.drawable));
    if (info.hasTexture && settings.texture) {
      items.push(createComponentItem(componentId, 'texture', `${info.label} 2`, settings.texture.min, settings.texture.max, data.texture));
    }
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

    items.push(createPropItem(propId, 'drawable', `${info.label} 1`, settings.drawable.min, settings.drawable.max, data.drawable));
    if (settings.texture) {
      items.push(createPropItem(propId, 'texture', `${info.label} 2`, settings.texture.min, settings.texture.max, data.texture));
    }
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

function renderItems(items) {
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

function handleRangeInput(event) {
  const id = event.target.dataset.itemId;
  const item = itemRegistry.get(id);
  if (!item) return;
  const value = clamp(parseNumber(event.target.value, item.step), item.min, item.max);
  item.value = value;
  updateNumberValue(id, value);
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
  fetchNui('appearance_save', state.appearance);
}

function handleExit() {
  fetchNui('appearance_exit');
}

function setupEventListeners() {
  document.getElementById('section-nav').addEventListener('click', handleNavClick);
  document.querySelectorAll('.camera-btn').forEach((button) => button.addEventListener('click', handleCameraClick));
  document.querySelectorAll('.rotate-btn').forEach((button) => button.addEventListener('click', handleRotateClick));
  document.getElementById('btn-turn').addEventListener('click', handleTurnClick);
  document.getElementById('btn-save').addEventListener('click', handleSave);
  document.getElementById('btn-exit').addEventListener('click', handleExit);
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
