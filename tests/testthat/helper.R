initFun <- function(silent = TRUE, ...) {
  remDr <- remoteDriver(browserName = "chrome", ...)
  remDr$open(silent)
  # set page load timeout to 20 secs
  remDr$setTimeout(milliseconds = 20000)
  # wait 5 secs for elements to load
  remDr$setTimeout(type = "implicit", milliseconds = 5000)
  htmlSrc <- if (identical(Sys.getenv("TRAVIS"), "true")) {
    "http-server:8080"
  } else {
    "localhost:3000"
  }
  loadPage <- function(pgStr) {
    paste0("http://", file.path(htmlSrc, paste0(pgStr, ".html")))
  }
  rdBrowser <- remDr$browserName


  list(remDr = remDr, rdBrowser = rdBrowser, loadPage = loadPage)
}
