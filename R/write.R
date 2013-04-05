writePNG <- function(image, target = raw(), meta = character())
{
  if(!is.character(meta)) 
    meta = sapply(meta, serializeBase64) # could use JSON rather than serialize & base64
  
  if (inherits(target, "connection")) {
    r <- .Call("write_png", image, raw(), meta, PACKAGE="png")
    writeBin(r, target)
    invisible(NULL)
  } else invisible(.Call("write_png", image, if (is.raw(target)) target else path.expand(target), meta, PACKAGE="png"))
}


serializeBase64 <-
function(x)
{
  if(is.character(x) && length(x) == 1)
    return(x)
  
  library(RCurl) # or base64 package
  base64(serialize(x, NULL))
}
