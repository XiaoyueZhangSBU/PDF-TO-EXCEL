install.packages("pdftools")
library(pdftools)
download.file("file:///Users/moon/Desktop/asmsdirectoryofmembers.pdf","asmsdirectoryofmembers.pdf")
text = pdf_text("asmsdirectoryofmembers.pdf")   ##read pdf
text1 = strsplit(text,"\n")   ##wrap new line


#cutout the header
text2 = list()

for(i in 1:32) {
  text2[[i]] = text1[[i]][2:length(text1[[i]])]
}


##展平数据
text3 = as.character(unlist(text2))

##词与词之间空格超过2个，则换行
text4 = strsplit(text3, "  ")

##剔除无数据成分
for (n in 1:length(text4)){
a = which(text4[[n]] == "")
for (i in 1:length(a)){
  text4[[n]][a[i]] = NA
}
text4[[n]] = na.omit(text4[[n]])
}

##所有数据整理为一列
text5 = list()

for (j in 1:length(text4)) {
  for(m in 1:length(text4[[j]])){
  text5[m*j] = text4[[j]][m]
  }
}


##选取带有“电话”的行信息
text_tel = grep("Tel:", text5)
tel = text5[text_tel]

##选取带有“邮箱”的行信息
text_email = grep("@", text5)
email = text5[text_email]

install.packages("stringr")
library(stringr)
text_name = list()
for (t in 1:length(text5)) {
  text_name[t] = grep(str_to_upper(text5))
}



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


