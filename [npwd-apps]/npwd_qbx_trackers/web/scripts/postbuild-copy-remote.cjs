const fs = require('fs');
const path = require('path');

try {
  const distDir = path.join(__dirname, '..', 'dist');
  // Copy remoteEntry to dist root to match NPWD discovery for some hosts
  const from = path.join(distDir, 'assets', 'remoteEntry.js');
  const to = path.join(distDir, 'remoteEntry.js');

  if (!fs.existsSync(distDir)) {
    console.warn('[postbuild] dist folder not found:', distDir);
    process.exit(0);
  }

  if (fs.existsSync(from)) {
    try {
      fs.copyFileSync(from, to);
      console.log('[postbuild] Copied remoteEntry.js to dist root');
    } catch (e) {
      console.warn('[postbuild] Failed to copy remoteEntry.js to root:', e.message);
    }
  } else {
    console.warn('[postbuild] remoteEntry.js not found under assets:', from);
  }

  // Make dist/index.html transparent and script-free to avoid overlay during multichar
  const indexPath = path.join(distDir, 'index.html');
  if (fs.existsSync(indexPath)) {
    let html = fs.readFileSync(indexPath, 'utf8');
    // Drop any script and stylesheet tags that would mount UI or set background
    html = html
      .replace(/<script[^>]*>[^<]*<\/script>/gi, '')
      .replace(/<script[^>]*src=[^>]*><\/script>/gi, '')
      .replace(/<link[^>]*rel=["']stylesheet["'][^>]*>/gi, '');
    // Ensure transparent bg
    if (!/background:transparent/.test(html)) {
      html = html.replace(
        /<head>/i,
        '<head>\n    <style>html,body{background:transparent!important;margin:0;padding:0}</style>'
      );
    }
    fs.writeFileSync(indexPath, html);
    console.log('[postbuild] Cleaned dist/index.html for transparent NUI');
  }

  // Ensure CSS is available at dist root (NPWD remoteEntry often expects it there)
  const assetsDir = path.join(distDir, 'assets');
  if (fs.existsSync(assetsDir)) {
    const files = fs.readdirSync(assetsDir).filter(f => /^style-.*\.css$/i.test(f));
    for (const f of files) {
      try {
        fs.copyFileSync(path.join(assetsDir, f), path.join(distDir, f));
        console.log(`[postbuild] Copied CSS to dist root: ${f}`);
      } catch (e) {
        console.warn('[postbuild] Failed to copy CSS to root:', f, e.message);
      }
    }
  }
} catch (e) {
  console.error('[postbuild] Failed to copy remoteEntry.js:', e);
  process.exit(0);
}
