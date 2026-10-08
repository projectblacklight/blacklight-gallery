import { supportsGridLanes, init } from "blacklight-gallery/grid-lanes-polyfill"

document.addEventListener("DOMContentLoaded", () => {
  if (!supportsGridLanes()) {
    init({ force: true })
  }
})

// When a thumbnail opens the slideshow modal, show the slide for that thumbnail.
// Bootstrap's carousel reads the current slide from the DOM, so moving the
// active class before the modal is shown is enough.
document.addEventListener("show.bs.modal", (event) => {
  const slideTo = event.relatedTarget?.dataset.bsSlideTo
  const items = event.target.querySelectorAll(".carousel-item")
  if (slideTo === undefined || !items[slideTo]) return

  items.forEach((item) => item.classList.remove("active"))
  items[slideTo].classList.add("active")
})
