// 使用旧语法，让低版本浏览器也能显示提示
(function () {
  var userAgent = navigator.userAgent;
  var browsers = [
    { pattern: /(?:Chrome|Chromium|EdgA?)\/(\d+)/, major: 85, minor: 0 },
    { pattern: /Firefox\/(\d+)/, major: 79, minor: 0 },
    { pattern: /Version\/(\d+)(?:\.(\d+))?.*Safari\//, major: 14, minor: 1 },
  ];
  for (var i = 0; i < browsers.length; i++) {
    var browser = browsers[i];
    var match = userAgent.match(browser.pattern);
    if (!match) {
      continue;
    }
    var major = parseInt(match[1], 10);
    var minor = parseInt(match[2] || "0", 10);
    if (
      major > browser.major ||
      (major === browser.major && minor >= browser.minor)
    ) {
      return;
    }
    break;
  }

  var warning = document.createElement("div");
  warning.setAttribute("role", "alert");
  warning.style.cssText =
    "position:fixed;top:0;right:0;bottom:0;left:0;z-index:2147483647;overflow:auto;background:#f0f2f5;color:#303133;font:16px/1.8 Arial,'Microsoft YaHei',sans-serif;";
  warning.innerHTML =
    '<div style="max-width:480px;margin:12vh auto;padding:32px;background:#fff;border-radius:12px;box-shadow:0 8px 32px rgba(0,0,0,.08);">' +
    '<h2 style="margin:0 0 16px;font-size:22px;">浏览器暂不受支持</h2>' +
    "<p>请升级浏览器后再访问本系统。</p>" +
    '<p style="color:#606266;font-size:14px;">最低支持：Chrome 85、Edge 85、Firefox 79、Safari 14.1。</p>' +
    "</div>";
  document.body.appendChild(warning);
})();
