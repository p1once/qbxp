import {
  CSSProperties,
  useCallback,
  useEffect,
  useMemo,
  useState,
} from 'react';
import { getLocale } from './locales';
import { fetchNui } from './utils/fetchNui';
import { relativeTime } from './utils/time';
import './styles.css';

type Tracker = {
  plate: string;
  installedAt?: number;
  net?: boolean;
};

type NuiListResponse = {
  status?: string;
  data?: Tracker[];
};

const mockTrackers: Tracker[] = [
  { plate: 'DEV123', installedAt: Math.floor(Date.now() / 1000) - 140, net: true },
  { plate: 'NPWD42', installedAt: Math.floor(Date.now() / 1000) - 3600, net: false },
];

const PLACEHOLDER_TOKEN = '{relative}';

const surfaceStyles = {
  glass: 'linear-gradient(145deg, rgba(18, 24, 38, 0.92), rgba(12, 16, 28, 0.85))',
};

const styles: Record<
  | 'app'
  | 'header'
  | 'title'
  | 'subtitle'
  | 'tools'
  | 'search'
  | 'refresh'
  | 'body'
  | 'card'
  | 'cardMeta'
  | 'cardPlate'
  | 'cardSub'
  | 'badgeLive'
  | 'badgeStale'
  | 'actions'
  | 'button'
  | 'empty'
  | 'status'
  | 'error',
  CSSProperties
> = {
  app: {
    display: 'flex',
    flexDirection: 'column',
    height: '100%',
    width: '100%',
    padding: '20px 18px',
    color: '#edf2ff',
    fontFamily: '"Segoe UI", system-ui, -apple-system, sans-serif',
    background:
      'radial-gradient(130% 120% at 10% 0%, rgba(102,209,255,0.25), rgba(12,15,20,0.92)), radial-gradient(110% 100% at 100% 100%, rgba(37,132,247,0.18), rgba(12,15,20,0.9))',
    backdropFilter: 'blur(8px)',
  },
  header: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: '14px',
    marginBottom: '18px',
    borderBottom: '1px solid rgba(255,255,255,0.08)',
    paddingBottom: '14px',
  },
  title: {
    margin: 0,
    fontSize: '19px',
    fontWeight: 700,
    letterSpacing: '0.6px',
  },
  subtitle: {
    margin: 0,
    fontSize: '12px',
    color: '#9fb2cc',
    opacity: 0.9,
  },
  tools: {
    display: 'flex',
    alignItems: 'center',
    gap: '10px',
    flex: 1,
  },
  search: {
    flex: 1,
    padding: '11px 14px',
    borderRadius: '12px',
    border: '1px solid rgba(255,255,255,0.14)',
    background: 'rgba(12, 19, 30, 0.88)',
    color: 'inherit',
    fontSize: '14px',
  },
  refresh: {
    padding: '11px 16px',
    borderRadius: '12px',
    border: '1px solid rgba(102,209,255,0.35)',
    background: 'transparent',
    color: '#d8f2ff',
    fontWeight: 600,
    fontSize: '14px',
    cursor: 'pointer',
  },
  body: {
    flex: 1,
    overflowY: 'auto',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'stretch',
    gap: '10px',
    paddingRight: '2px',
  },
  card: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    gap: '12px',
    padding: '12px 14px',
    borderRadius: '14px',
    background: surfaceStyles.glass,
    border: '1px solid rgba(255,255,255,0.08)',
    boxShadow: '0 12px 28px rgba(9,17,31,0.30)',
    minHeight: '74px',
    width: '100%',
  },
  cardMeta: {
    display: 'flex',
    flexDirection: 'column',
    gap: '4px',
  },
  cardPlate: {
    fontSize: '16px',
    fontWeight: 700,
    letterSpacing: '0.8px',
  },
  cardSub: {
    fontSize: '11px',
    color: '#9fb2cc',
  },
  badgeLive: {
    padding: '5px 10px',
    borderRadius: '999px',
    background: 'rgba(30, 178, 120, 0.22)',
    color: '#8effc7',
    fontWeight: 600,
    fontSize: '12px',
  },
  badgeStale: {
    padding: '5px 10px',
    borderRadius: '999px',
    background: 'rgba(214, 139, 34, 0.2)',
    color: '#f7d09b',
    fontWeight: 600,
    fontSize: '12px',
  },
  actions: {
    display: 'flex',
    alignItems: 'center',
    gap: '8px',
  },
  button: {
    padding: '9px 14px',
    borderRadius: '11px',
    border: 'none',
    fontWeight: 600,
    fontSize: '13px',
    background: 'linear-gradient(135deg, #66d1ff, #2a9df4)',
    color: '#082b42',
    cursor: 'pointer',
    transition: 'transform 0.1s ease, filter 0.15s ease',
  },
  empty: {
    textAlign: 'center',
    marginTop: '40px',
    color: '#9fb2cc',
    fontSize: '14px',
  },
  status: {
    fontSize: '13px',
    color: '#9fb2cc',
  },
  error: {
    background: 'rgba(200,40,40,0.18)',
    border: '1px solid rgba(200,40,40,0.38)',
    color: '#ffe4e4',
    padding: '12px 14px',
    borderRadius: '12px',
    fontSize: '13px',
  },
};

const useDelayedVisibility = (active: boolean, delay = 120) => {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    let timer: number | undefined;

    if (active) {
      timer = window.setTimeout(() => setVisible(true), delay);
    } else {
      setVisible(false);
    }

    return () => {
      if (timer !== undefined) {
        window.clearTimeout(timer);
      }
    };
  }, [active, delay]);

  return visible;
};

const useTrackers = () => {
  const locale = useMemo(() => getLocale(), []);
  const [query, setQuery] = useState('');
  const [entries, setEntries] = useState<Tracker[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const payload = await fetchNui<NuiListResponse>(
        'npwd:qbx_trackers:list',
        undefined,
        { status: 'ok', data: mockTrackers },
      );
      const list = Array.isArray(payload) ? payload : payload?.data ?? [];
      setEntries(list);
    } catch (err) {
      console.error('Failed to fetch tracker list', err);
      setError(locale.errorLoading);
    } finally {
      setLoading(false);
    }
  }, [locale.errorLoading]);

  useEffect(() => {
    load();
  }, [load]);

  useEffect(() => {
    const handler = (event: MessageEvent) => {
      if (event.data?.action === 'npwd:visibility' && event.data.visibility) {
        load();
      }
    };
    window.addEventListener('message', handler);
    return () => window.removeEventListener('message', handler);
  }, [load]);

  const filtered = useMemo(() => {
    const q = query.trim().toUpperCase();
    if (!q) return entries;
    return entries.filter((entry) => entry.plate?.toUpperCase().includes(q));
  }, [entries, query]);

  return {
    locale,
    query,
    setQuery,
    entries: filtered,
    refresh: load,
    loading,
    error,
  };
};

const installedText = (template: string, relativeLabel: string) =>
  template.includes(PLACEHOLDER_TOKEN) ? template.replace(PLACEHOLDER_TOKEN, relativeLabel) : template;

const useDelayedEmptyState = (loading: boolean, hasEntries: boolean, delay = 220) => {
  const [showEmpty, setShowEmpty] = useState(false);

  useEffect(() => {
    if (loading || hasEntries) {
      setShowEmpty(false);
      return;
    }

    const timer = window.setTimeout(() => setShowEmpty(true), delay);
    return () => window.clearTimeout(timer);
  }, [delay, hasEntries, loading]);

  return showEmpty;
};

const TrackersApp = () => {
  const { locale, query, setQuery, entries, refresh, loading, error } = useTrackers();
  const showLoading = useDelayedVisibility(loading);

  const onPing = useCallback(async (plate: string) => {
    if (!plate) return;
    try {
      await fetchNui('npwd:qbx_trackers:requestWaypoint', { plate });
    } catch (err) {
      console.error('Failed to ping tracker', err);
    }
  }, []);

  return (
    <div style={styles.app} className="app trackers-app">
      <header style={styles.header} className="app__header">
        <div>
          <h1 style={styles.title} className="app__title">
            {locale.title}
          </h1>
          <p style={styles.subtitle}>Suivez vos traqueurs en temps réel et posez un ping instantané.</p>
        </div>
        <div style={styles.tools} className="app__tools">
          <input
            style={styles.search}
            className="app__search"
            value={query}
            onChange={(event) => setQuery(event.target.value)}
            placeholder={locale.searchPlaceholder}
          />
          <button
            style={{ ...styles.refresh, opacity: loading ? 0.6 : 1 }}
            className="button button--ghost"
            onClick={refresh}
            disabled={loading}
          >
            {locale.refresh}
          </button>
        </div>
      </header>

      {error && (
        <div style={styles.error} className="error">
          {error}
        </div>
      )}
      {showLoading && (
        <div style={styles.status} className="status">
          {locale.loading}
        </div>
      )}

      <div style={styles.body} className="content">
        {showEmpty && (
          <div style={styles.empty} className="empty">
            {locale.empty}
          </div>
        )}

        {entries.map((entry) => {
          const relative = relativeTime(entry.installedAt, locale);
          const installedLabel = installedText(locale.installedTemplate, relative);
          return (
            <article style={styles.card} className="card" key={entry.plate}>
              <div style={styles.cardMeta} className="card__meta">
                <div style={styles.cardPlate} className="card__plate">
                  {entry.plate}
                </div>
                <div style={styles.cardSub} className="card__sub">
                  {installedLabel}
                </div>
              </div>
              <div style={styles.actions} className="card__actions">
                <span
                  style={entry.net ? styles.badgeLive : styles.badgeStale}
                  className={`badge ${entry.net ? 'badge--live' : 'badge--stale'}`}
                >
                  {entry.net ? locale.live : locale.stale}
                </span>
                <button style={styles.button} className="button" onClick={() => onPing(entry.plate)}>
                  {locale.ping}
                </button>
              </div>
            </article>
          );
        })}
      </div>
    </div>
  );
};

type IconProps = {
  fontSize?: 'small' | 'large';
};

const PinIcon = ({ fontSize = 'large' }: IconProps) => {
  const size = fontSize === 'large' ? 32 : 24;
  return (
    <svg viewBox="0 0 24 24" width={size} height={size} fill="currentColor">
      <path d="M12 2a7 7 0 0 0-7 7c0 5.25 7 13 7 13s7-7.75 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z" />
    </svg>
  );
};

export const AppIcon = (props: IconProps) => <PinIcon {...props} />;
export const NotificationIcon = (props: IconProps) => <PinIcon {...props} />;

export default TrackersApp;
