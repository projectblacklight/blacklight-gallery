import "blacklight-gallery/slideshow"

import { supportsGridLanes, init } from "blacklight-gallery/grid-lanes-polyfill"

document.addEventListener("DOMContentLoaded", () => {
  if (!supportsGridLanes()) {
    init({ force: true })
  }
})
