;(function () {
  var Slideshow = function (element, options) {
    this.element = element
    this.options = options
    this.paused = false
    this.activeIndex = 0

    this.init = function () {
      this.items = Array.from(this.element.querySelectorAll(".item"))
    }

    this.attachEvents()
    this.init()
  }

  Slideshow.prototype = {
    slide: function (item) {
      this.items.forEach(el => (el.style.display = "none"))
      item.style.display = "block"

      this.activeIndex = this.items.indexOf(item)

      if (this.options.autoPlay && !this.paused) this.play()

      return this
    },

    play: function () {
      this.paused = false

      if (this.interval) clearInterval(this.interval)
      this.interval = setInterval(this.next.bind(this), this.options.interval)
    },

    pause: function () {
      this.paused = true
      clearInterval(this.interval)
      this.interval = null

      return this
    },

    startAt: function (pos) {
      this.to(pos)
    },

    next: function () {
      return this.to("next")
    },

    to: function (pos) {
      if (pos === "next") pos = this.activeIndex + 1
      if (pos === "prev") pos = this.activeIndex - 1

      return this.slide(this.items[this.getValidIndex(pos)])
    },

    getValidIndex: function (index) {
      if (typeof index === "undefined" || index > this.items.length - 1)
        index = 0
      if (index < 0) index = this.items.length - 1

      return index
    },

    attachEvents: function () {
      var _this = this

      document.addEventListener("click", function (e) {
        var target = e.target.closest('[data-behavior="pause-slideshow"]')
        if (target) {
          e.preventDefault()
          _this.pause()
        }
      })

      document.addEventListener("click", function (e) {
        var target = e.target.closest('[data-behavior="start-slideshow"]')
        if (target) {
          e.preventDefault()
          _this.play()
        }
      })

      document.addEventListener("click", function (e) {
        var target = e.target.closest(
          "[data-slide], [data-bs-slide], [data-slide-to], [data-bs-slide-to]"
        )
        if (target) {
          e.preventDefault()

          const pos =
            parseInt(
              target.getAttribute("data-slide-to") ||
                target.getAttribute("data-bs-slide-to"),
              10
            ) ||
            target.getAttribute("data-slide") ||
            target.getAttribute("data-bs-slide")

          if (pos === "next" || pos === "prev") _this.pause()
          _this.to(pos)
        }
      })

      // pause slideshow on modal close
      var modal = document.getElementById("slideshow-modal")
      if (modal) {
        modal.addEventListener("hidden.bs.modal", function () {
          _this.pause()
        })
      }
    }
  }

  Slideshow.DEFAULTS = {
    autoPlay: false,
    interval: 5000 // in milliseconds
  }

  // Helper function to merge objects (replaces $.extend)
  function extend() {
    var extended = {}
    var i = 0

    for (; i < arguments.length; i++) {
      var obj = arguments[i]
      for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
          extended[key] = obj[key]
        }
      }
    }

    return extended
  }

  // Helper function to get data attributes as object
  function getDataAttributes(element) {
    var data = {}
    Array.from(element.attributes).forEach(function (attr) {
      if (attr.name.indexOf("data-") === 0) {
        var camelCase = attr.name
          .substr(5)
          .replace(/-(.)/g, function (match, chr) {
            return chr.toUpperCase()
          })
        data[camelCase] = attr.value
      }
    })
    return data
  }

  // Public initialization function
  window.initSlideshow = function (selector, option) {
    var elements =
      typeof selector === "string"
        ? document.querySelectorAll(selector)
        : [selector]

    Array.from(elements).forEach(function (element) {
      var data = element._slideshow
      var dataAttrs = getDataAttributes(element)
      var options = extend(
        {},
        Slideshow.DEFAULTS,
        dataAttrs,
        typeof option == "object" ? option : {}
      )

      if (!data) {
        element._slideshow = new Slideshow(element, options)
      }
    })
  }
})()
