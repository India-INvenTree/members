# read the member list
member_list <- read.csv("files/member_list.csv", header = TRUE, sep = ",")

for (member in 1:nrow(member_list)) {
    # member name
    member_data <- member_list[member, ]
    name <- paste0(member_data$First.Name, "_", member_data$Last.Name)

    # create the member's page as a qmd file

    member_page <- file.create(paste("files/", name, ".qmd", sep = ""))
    fileConn <- file(paste("files/", name, ".qmd", sep = ""), open = "w")
    writeLines(c(
        "---",
        paste0("title: \"", member_data$First.Name, " ", member_data$Last.Name, "\""),
        # url
        paste0("aliases: ", name, ".html"),
        "---"
    ), fileConn)
    close(fileConn)

    # add line to the index file
    index_page <- file("index.qmd", open = "a")
    writeLines(c(
        paste0("- [", member_data$First.Name, " ", member_data$Last.Name, "](./", name, ".html)")
    ), index_page)
    close(index_page)
}
