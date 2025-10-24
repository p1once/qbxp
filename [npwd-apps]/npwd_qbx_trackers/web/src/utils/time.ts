import type { TrackerLocale } from '../locales';

const SECONDS_IN_MINUTE = 60;
const SECONDS_IN_HOUR = 60 * SECONDS_IN_MINUTE;
const SECONDS_IN_DAY = 24 * SECONDS_IN_HOUR;

export const relativeTime = (timestampSeconds: number | undefined, locale: TrackerLocale): string => {
  if (!timestampSeconds || Number.isNaN(timestampSeconds)) {
    return '-';
  }

  const now = Math.floor(Date.now() / 1000);
  const delta = Math.max(0, now - Math.floor(timestampSeconds));

  if (delta < SECONDS_IN_MINUTE) {
    return `${delta}${locale.relative.seconds}`;
  }

  if (delta < SECONDS_IN_HOUR) {
    const minutes = Math.floor(delta / SECONDS_IN_MINUTE);
    return `${minutes}${locale.relative.minutes}`;
  }

  if (delta < SECONDS_IN_DAY) {
    const hours = Math.floor(delta / SECONDS_IN_HOUR);
    return `${hours}${locale.relative.hours}`;
  }

  const days = Math.floor(delta / SECONDS_IN_DAY);
  return `${days}${locale.relative.days}`;
};
