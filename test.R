library(png)
img <- readPNG(system.file("img","Rlogo.png",package="png"))
writePNG(img, "/tmp/test.png", c(provenance = "Testing 123", other = "ABC"))
o =readPNG("/tmp/test.png", meta = TRUE)
o[[2]]
