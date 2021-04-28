var pkg = require('./package.json');

module.exports = {
  title: 'Sample book',
  // Enforce use of GitBook v3
  gitbook: '3.2.3',
  
  // Use the "official" theme
  plugins: [
    "highlight",
    "-sharing",
    "hide-published-with",
    "search",
    "include-codeblock",
    "japanese-support",
    "footnote-string-to-number",
    "anchors",
    "ace",
    "navigator",
      "collapsible-menu",
      "image-captions"
    ],

    variables: {
      version: pkg.version
    },
    
    pluginsConfig: {},

    "styles": {
        "website": "styles/website.css",
        "pdf": "styles/pdf.css"
    },
    "pdf": {
        "fontFamily": "NotoSans-Bold"
    },
    "language": "ja"
};
