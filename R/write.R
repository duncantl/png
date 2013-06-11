RMetaDataEncodingField = ".Rbase64Enconded"
writePNG <- function(image, target = raw(), meta = character())
{
  if(!is.character(meta))  {
     # The caller can do the conversion first if they need control.
     # could use another format, e.g. JSON, rather than R's serialize & base64
     # This would allow other applications to read the contents.
    meta = lapply(meta, serializeBase64)
    enc = !sapply(meta, function(x) is.null(attr(x, "base64")))
    meta = unlist(meta)
    meta[RMetaDataEncodingField] = serializeBase64(names(meta)[enc], force = TRUE)
  }
  
  if (inherits(target, "connection")) {
    r <- .Call("write_png", image, raw(), meta, PACKAGE="png")
    writeBin(r, target)
    invisible(NULL)
  } else invisible(.Call("write_png", image, if (is.raw(target)) target else path.expand(target), meta, PACKAGE="png"))
}


serializeBase64 <-
  #
  #  encode an object as base64 if it is not already a character string.
  #  We serialize it and then encode it.
  #
function(x, force = FALSE)
{
  if(!force && is.character(x) && length(x) == 1)
    return(x)

  structure(base64encode(serialize(x, NULL), 0), base64 = TRUE)
}

unserializeBase64 <-
function(x)
{
  unserialize(base64decode(x))
}

