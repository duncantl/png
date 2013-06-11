readPNG <- function(source, native = FALSE, metadata = FALSE)
{  
  ans <- .Call("read_png", if (is.raw(source)) source else path.expand(source), native, as.logical(metadata), PACKAGE="png")
  if(metadata) 
          # I'd be happy also putting the meta data as an attribute.
    ans <- structure(ans[[1]], metadata = unencodeMetadata(ans[[2]]))
  
  ans
}


unencodeMetadata =
function(vals)
{
   enc <- vals[RMetaDataEncodingField]
   if(!is.na(enc)) {
      vals = vals[ - match(RMetaDataEncodingField, names(vals)) ]
      vars = unserializeBase64(enc)
      if(length(vars)) {
        vals = as.list(vals)
        vals[vars] = lapply(vals[vars], unserializeBase64)
      }
   }
   vals
}
