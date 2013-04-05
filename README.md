This is a direct copy of Simon Urbanek's very nice and useful png
package (on CRAN) for reading and writing PNG images from within R.
The only addition is to allow the reading and writing of meta data
within the PNG image.  One of the motivations for this is to be able
to include provenance information directly within an image and to be
able to access this from within R. This is related to the rProv
package some of us are working on.