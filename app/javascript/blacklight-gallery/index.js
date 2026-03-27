import bootstrap from "bootstrap"

import { supportsGridLanes, init } from "blacklight-gallery/grid-lanes-polyfill"

document.addEventListener("DOMContentLoaded", () => {
  if (!supportsGridLanes()) {
    init({ force: true })
  }
})

const carousel = new bootstrap.Carousel("#slideshow")
