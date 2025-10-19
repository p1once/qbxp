export type TrackerLocale = {
  title: string;
  searchPlaceholder: string;
  refresh: string;
  empty: string;
  ping: string;
  installedTemplate: string;
  live: string;
  stale: string;
  errorLoading: string;
  loading: string;
  relative: {
    seconds: string;
    minutes: string;
    hours: string;
    days: string;
  };
};

const LOCALES: Record<string, TrackerLocale> = {
  en: {
    title: 'GPS Trackers',
    searchPlaceholder: 'Search plate...',
    refresh: 'Refresh',
    empty: 'No trackers installed.',
    ping: 'Ping',
    installedTemplate: 'Installed {relative} ago',
    live: 'Live',
    stale: 'Out of range',
    errorLoading: 'Unable to load trackers. Please try again.',
    loading: 'Loading...',
    relative: {
      seconds: 's',
      minutes: 'm',
      hours: 'h',
      days: 'd',
    },
  },
  fr: {
    title: 'Traqueurs GPS',
    searchPlaceholder: 'Rechercher une plaque...',
    refresh: 'Rafraichir',
    empty: 'Aucun traqueur installe.',
    ping: 'Pinger',
    installedTemplate: 'Installe il y a {relative}',
    live: 'Actif',
    stale: 'Hors portee',
    errorLoading: 'Impossible de charger la liste des traqueurs.',
    loading: 'Chargement...',
    relative: {
      seconds: 's',
      minutes: 'm',
      hours: 'h',
      days: 'j',
    },
  },
};

const sanitizeLang = (lang: string) => lang.trim().toLowerCase();

export const getLocale = (): TrackerLocale => {
  const fallback = LOCALES.en;
  const rawLang =
    (window as unknown as { __NPWD_LANG__?: string }).__NPWD_LANG__ ??
    (navigator.language || 'en');
  const lang = sanitizeLang(rawLang).split('-')[0];
  return LOCALES[lang] ?? fallback;
};
