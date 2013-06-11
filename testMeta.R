library(png)
img <- readPNG(system.file("img", "Rlogo.png", package="png"))
writePNG(img, "/tmp/test.png", c(provenance = "Testing 123", other = "ABC"))
o = readPNG("/tmp/test.png", meta = TRUE)
attr(o, "metadata")

writePNG(img, "/tmp/test.png", list(timestamp = as.character(Sys.time()), when = Sys.time(), other = "ABC",
                                      session = sessionInfo(), system = Sys.info()))
o = readPNG("/tmp/test.png", meta = TRUE)
m = attr(o, "metadata")
names(m)

###########
# Use JSON

library(RJSONIO)

meta = list(timestamp = as.character(Sys.time()), when = Sys.time(), other = "ABC",
                                      session = sessionInfo(), system = Sys.info())
meta.json = sapply(meta, toJSON)
writePNG(img, "/tmp/test.png", meta.json)
img = readPNG("/tmp/test.png", meta = TRUE)
m = lapply(attr(img, "metadata"), fromJSON)

# We lose the class information for the when and the elements of session.
# We can use a more R-specific version of JSON, e.g. Jeroen Oom's attribute-based
# output.

