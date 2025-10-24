import TrackersApp, { AppIcon, NotificationIcon } from './src/App';

export const path = '/npwd_qbx_trackers';

export default () => ({
  id: 'npwd_qbx_trackers',
  nameLocale: 'Trackers',
  color: '#ffffff',
  backgroundColor: '#0b2b3b',
  path,
  icon: AppIcon,
  app: TrackersApp,
  notificationIcon: NotificationIcon,
});
