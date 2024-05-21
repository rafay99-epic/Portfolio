'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"icons/Icon-maskable-192.png": "0a9541dc7db88dd77bef40fdc91ad085",
"icons/Icon-maskable-512.png": "fc4c6e8ebad606bf44c3fbfe3e7b3f2a",
"icons/Icon-512.png": "fc4c6e8ebad606bf44c3fbfe3e7b3f2a",
"icons/Icon-192.png": "0a9541dc7db88dd77bef40fdc91ad085",
"manifest.json": "c7b3139932bc76ab603e1f915eea5102",
"favicon.png": "a6ef18c225f642f97548c5bb725a471e",
"2favicon.png": "53781e8dd0698320d237bc5d4767e1f1",
"flutter_bootstrap.js": "183215b63c4591d14babd56cd5d8545f",
"version.json": "f4915ffd2ef0645a1e1a2fcc1460a668",
"sitemap.xml": "53406c37f1addfc3025e8888effe23fa",
"index.html": "20d64f331a37d7cdc48d2246aa350459",
"/": "20d64f331a37d7cdc48d2246aa350459",
"main.dart.js": "45b903248dad1e6a303e579f75840644",
"assets/AssetManifest.json": "8d1eda2a0b02eeb5eef234067fb10370",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/packages/html_editor_enhanced/assets/summernote-lite.min.js": "4fe75f9b35f43da141d60d6a697db1c1",
"assets/packages/html_editor_enhanced/assets/jquery.min.js": "b61aa6e2d68d21b3546b5b418bf0e9c3",
"assets/packages/html_editor_enhanced/assets/summernote-no-plugins.html": "89ca56cd85a91f1dc39f5413204e24d0",
"assets/packages/html_editor_enhanced/assets/summernote-lite.min.css": "570da368f96dc6433b8a1006c425ca7d",
"assets/packages/html_editor_enhanced/assets/font/summernote.eot": "f4a47ce92c02ef70fc848508f4cec94a",
"assets/packages/html_editor_enhanced/assets/font/summernote.ttf": "82fa597f29de41cd41a7c402bcf09ba5",
"assets/packages/html_editor_enhanced/assets/summernote.html": "8ce8915ee5696d3c568e94911eb0d9bf",
"assets/packages/html_editor_enhanced/assets/summernote-lite-dark.css": "3f3cb618d1d51e3e6d0d4cce469b991b",
"assets/packages/html_editor_enhanced/assets/plugins/summernote-at-mention/summernote-at-mention.js": "8d1a7c753cf1a4cd0058e31fa1e5376e",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2ab0352de23223930259e35f10632ff6",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "7111e8d1bc53c893f9c644d80e9243ac",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "3b723a80672a5800b41b307459cb623e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "c3cd002c5a87ffd3f06e6fbb126ce4ca",
"assets/fonts/MaterialIcons-Regular.otf": "f2c2cea4e0700e40c8fec79cb6994c87",
"assets/assets/pdf/resume.pdf": "48fe78a2f1c795c07b847d18b1574586",
"assets/assets/animation/datanotfound.json": "4a61d51cbb1148f2b3a8a3cbbb027f63",
"assets/assets/animation/contact.json": "4f2a350589cfca2c5022ac1c5b2b7874",
"assets/assets/animation/web_app_dev.json": "21bea1fb1b99c7d64eee37ace6da205a",
"assets/assets/animation/expertise.json": "0a4daaa9404373df60fbf8c0e9cf4c6e",
"assets/assets/animation/mobile_app_dev.json": "dffd21d38ca5c133997f100c44787e81",
"assets/assets/animation/loader.json": "b90bcb6ceb76c0b8d884749a00dc68e4",
"assets/assets/animation/AI.json": "8cf5e6cf3a1929d2387ac43ede9ed684",
"assets/assets/animation/about_me_animation.json": "1fa159c75a4be9b3134a0c8b7b13b0fc",
"assets/assets/animation/noInternet.json": "591f3698bfee70773c51df477d94624f",
"assets/assets/animation/404-new.json": "4931f7ed045eeb1fd9290d43e218a4ce",
"assets/assets/animation/rafay_animation.json": "e440e31bb3bec753c3ed2b5755630f8c",
"assets/assets/animation/jar-loading.json": "3003e5e96e7a929c97d3c494ac17eedf",
"assets/assets/animation/admin.json": "118f8c3c5a102217f3aad48805280add",
"assets/assets/animation/about_me.json": "8ce533e95e315311554b16822cb15396",
"assets/assets/animation/otp.json": "5827ed6ba8fbdcb795508232bb489b72",
"assets/assets/image/DienstleistoIntroScreen.png": "d523e68b7ba23ed422a91cfb13804543",
"assets/assets/image/favicon.png": "53781e8dd0698320d237bc5d4767e1f1",
"assets/assets/image/ChessMaster.png": "7d825ba1901bd4d393610537c509c1a6",
"assets/assets/image/chessMaster2.png": "f55b4fe2393f523721b5cc37e1751ccc",
"assets/assets/image/chessimage_chroped.png": "251b55cafe37df27ddc29b84947bb3f1",
"assets/assets/image/SimpleThread.png": "ddc6223a7cb8d696fea681b2bbc4c285",
"assets/assets/image/logout.png": "91da90550c4dfe78defcb055e6617037",
"assets/assets/image/ParkingAssistant.png": "e263a7e8c04b24cb7dcd929aedff37a7",
"assets/assets/image/future-insight.png": "a533fc160e9198b6ead3dff90a4d1afd",
"assets/assets/image/shafiqLawChamber.png": "1ab67c9b7ed91085768f0689b4ac223e",
"assets/assets/image/inboxMessages.png": "621847830b69b8ce137843d7cb3b79ec",
"assets/assets/image/contactMe.png": "0873b2a0e4a5534ed5a5de08da9ad3eb",
"assets/assets/image/author.jpg": "4d98dbf6a2bd7e84533767bdeac7fbbf",
"assets/assets/image/archiveMessages.png": "099b1954e69d281a3a5ddebbd56b309d",
"assets/assets/image/CoverPageCheckPoint.png": "02851d17884d46eb76d111018532631f",
"assets/assets/image/Thumbnail.png": "9d2ca09c1ed4eecd706f1f2902e69794",
"assets/assets/image/blog.png": "838f4d461e2568f7faf0545fe84fdb9a",
"assets/assets/image/Smart-Parking-Assistant.png": "959242d439a22958874a329d84401ffc",
"assets/NOTICES": "e5f53d3af183b7c7d90780e6ad8a8fbd",
"assets/AssetManifest.bin": "9ca01439b373ed04209da8ad9e79829e",
"assets/FontManifest.json": "3ddd9b2ab1c2ae162d46e3cc7b78ba88",
"_redirects": "d3f02c1e572a02b03f656b8e7b320d3b",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
