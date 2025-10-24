import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { isEnvBrowser } from './utils/fetchNui';

// Only mount the standalone UI in a real browser (dev/preview).
// In the FiveM NUI environment, NPWD consumes the module federation exposure
// and renders inside the phone; we keep this page blank to avoid leaking UI
// during character selection or other NUI screens.
if (isEnvBrowser() && document.getElementById('root')) {
  ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
    <React.StrictMode>
      <App />
    </React.StrictMode>,
  );
}
