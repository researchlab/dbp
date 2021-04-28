# はじめに

設定はこんな感じ

```js
var pkg = require('./package.json');

module.exports = {
  title: 'Your Book Name',
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
    "uml",
    "image-captions"
    ],

    variables: {
      version: pkg.version
    },
    
    pluginsConfig: {},

    "title": "WebAuthentication本",
    "structure": {
    },
    "styles": {
        "website": "styles/website.css",
        "pdf": "styles/pdf.css"
    },
    "pdf": {
        "fontFamily": "NotoSans-Bold"
    },
    "language": "ja"
};
```

表紙は jpeg で cover.jpg

<div style="page-break-after: always;"></div>

あとは 

```sh
docker run --rm -v "$(pwd)/sample:/book"  -p 4000:4000  hwataru/gitbook-pdf gitbook install
docker run --rm -v "$(pwd)/sample:/book"  -p 4000:4000  hwataru/gitbook-pdf gitbook pdf
```
