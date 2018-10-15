install.packages("pdftools")
library(pdftools)
download.file("file:///Users/moon/Desktop/asmsdirectoryofmembers.pdf","asmsdirectoryofmembers.pdf")
text = pdf_text("asmsdirectoryofmembers.pdf")   ##read pdf
text2 = strsplit(text,"\n")   ##wrap new line

####transfer vector to string
# install.packages("httr")
# library(httr)
# doc = content(text2,as = "text")  ##


#cutout the header
pagehead = grep("ASMS Directory of Members", text2, fixed = TRUE)
text2 = doc[(pagehead + 1):length(text2)]
#######

library(stringr)
doc_split = str_split(text2, "  ")
doc_split = lapply(doc_split,function(x) {
  doc1 = x[1:8][x[1:8] != ""] [1]
  if (is.na(doc1)) doc1 = ""
  doc2 = x[x != ""]
  if (doc1 != "") doc2 = doc2[-1]
  if(length(doc2) == 0) doc2 = ""
  if(is.na(doc2)) doc2 = "" 
  doc3 = x[x !=""]
  if(doc2 != "") doc3 = doc3[-1]
  if(length(doc3) == 0) doc3 = ""
  while (sum(nchar(doc3)) >65) {
    doc1 = paste(doc1, doc2[1], doc3[1], collapse = " ")
    doc2 = doc2[-1]
    doc3 = doc3[-1]
  }
  doc3 = paste(doc3,collapse = " ")
  doc1 = str_trim(doc1)
  doc2 = str_trim(doc2)
  doc3 = str_trim(doc3)
  list(doc1 = doc1, doc2 = doc2, doc3 = doc3)
})

doc1 = sapply(doc_split,'[[',1)
doc2 = sapply(doc_split,'[[',2)
doc3 = sapply(doc_split,'[[',3)


page_rows = c(0, which(doc1 == "page"), length(doc1))
doc = c()
for ( i in 1:(length(page_rows)-1)) {
  doc = c(doc,c(doc1[(page_rows[i]+1):page_rows[i+1]], doc2[(page_rows[i]+1):page_rows[i+1]]))}
doc = doc[doc != "page"]

###write into xlsx
xlsxfile = paste(1:32, ".xlsx", sep=" ")
for (i in 1:32) {
  text[[i]] = paste("/User/moon/Desktop", xlsxfile[i], sep = " ")
  write.csv(data.list2[[i]], text2)
}
