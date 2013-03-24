readPNG <- function(source, native=FALSE, metadata = FALSE)
{  
  ans = .Call("read_png", if (is.raw(source)) source else path.expand(source), native, as.logical(metadata), PACKAGE="png")
  if(metadata)
    names(ans) = c("data", "metadata")
  
  ans
}
