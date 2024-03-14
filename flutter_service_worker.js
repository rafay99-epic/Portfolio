'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "fdea0dc121da2d26b17e911d80720445",
"/": "fdea0dc121da2d26b17e911d80720445",
"_redirects": "d3f02c1e572a02b03f656b8e7b320d3b",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "53781e8dd0698320d237bc5d4767e1f1",
"assets/FontManifest.json": "7868c4923a3c0189c8f431acd90832c9",
"assets/fonts/MaterialIcons-Regular.otf": "f87399a9aa67692ca12653241cd1c36b",
"assets/AssetManifest.bin.json": "0b3bbdaefa70ff4c8b500dc704dca134",
"assets/assets/image/blog.png": "838f4d461e2568f7faf0545fe84fdb9a",
"assets/assets/image/inboxMessages.png": "621847830b69b8ce137843d7cb3b79ec",
"assets/assets/image/favicon.png": "53781e8dd0698320d237bc5d4767e1f1",
"assets/assets/image/author.jpg": "4d98dbf6a2bd7e84533767bdeac7fbbf",
"assets/assets/image/logout.png": "91da90550c4dfe78defcb055e6617037",
"assets/assets/image/archiveMessages.png": "099b1954e69d281a3a5ddebbd56b309d",
"assets/assets/image/contactMe.png": "0873b2a0e4a5534ed5a5de08da9ad3eb",
"assets/assets/animation/about_me.json": "8ce533e95e315311554b16822cb15396",
"assets/assets/animation/AI.json": "8cf5e6cf3a1929d2387ac43ede9ed684",
"assets/assets/animation/web_app_dev.json": "21bea1fb1b99c7d64eee37ace6da205a",
"assets/assets/animation/mobile_app_dev.json": "dffd21d38ca5c133997f100c44787e81",
"assets/assets/animation/expertise.json": "0a4daaa9404373df60fbf8c0e9cf4c6e",
"assets/assets/animation/contact.json": "4f2a350589cfca2c5022ac1c5b2b7874",
"assets/assets/animation/admin.json": "118f8c3c5a102217f3aad48805280add",
"assets/assets/animation/loader.json": "b90bcb6ceb76c0b8d884749a00dc68e4",
"assets/assets/animation/jar-loading.json": "3003e5e96e7a929c97d3c494ac17eedf",
"assets/assets/animation/404-new.json": "4931f7ed045eeb1fd9290d43e218a4ce",
"assets/assets/animation/datanotfound.json": "4a61d51cbb1148f2b3a8a3cbbb027f63",
"assets/assets/animation/rafay_animation.json": "e440e31bb3bec753c3ed2b5755630f8c",
"assets/AssetManifest.bin": "fd3d6dec7952899241863a2d80dc4ecc",
"assets/NOTICES": "b09d8268629a29ece97ff7526b19c9eb",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/packages/html_editor_enhanced/assets/summernote-lite.min.css": "570da368f96dc6433b8a1006c425ca7d",
"assets/packages/html_editor_enhanced/assets/summernote-lite.min.js": "4fe75f9b35f43da141d60d6a697db1c1",
"assets/packages/html_editor_enhanced/assets/plugins/summernote-at-mention/summernote-at-mention.js": "8d1a7c753cf1a4cd0058e31fa1e5376e",
"assets/packages/html_editor_enhanced/assets/summernote-lite-dark.css": "3f3cb618d1d51e3e6d0d4cce469b991b",
"assets/packages/html_editor_enhanced/assets/font/summernote.ttf": "82fa597f29de41cd41a7c402bcf09ba5",
"assets/packages/html_editor_enhanced/assets/font/summernote.eot": "f4a47ce92c02ef70fc848508f4cec94a",
"assets/packages/html_editor_enhanced/assets/summernote.html": "8ce8915ee5696d3c568e94911eb0d9bf",
"assets/packages/html_editor_enhanced/assets/jquery.min.js": "b61aa6e2d68d21b3546b5b418bf0e9c3",
"assets/packages/html_editor_enhanced/assets/summernote-no-plugins.html": "89ca56cd85a91f1dc39f5413204e24d0",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/iconly/fonts/IconlyBroken.ttf": "ae60c99d5cf25644beb25a87577bf6ca",
"assets/packages/iconly/fonts/IconlyLight.ttf": "baf08d3e753c86f1bdacb3535d66e2aa",
"assets/packages/iconly/fonts/IconlyBold.ttf": "6c73fc0a864250644f562a679591e0a4",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "fc203419d700a8a6a7c63ccb95c71147",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "afed5140935b03e1a4487ebb2a6b8137",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "ae60fe722d5e3b705dc5a9cb353c1c18",
"assets/AssetManifest.json": "69511b907a8696f7c4dd8dca804da519",
"version.json": "193e08366178f5438b17d871ed64b65d",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "e06f2e882df95a1f07e00df74d795188",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"main.dart.js": "3b5e2753e499591707f1dcc04e4f24e9"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
