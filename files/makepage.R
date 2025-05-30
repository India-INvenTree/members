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
        "---",
        "",
        "::::{.columns}",
        ":::{.column}",
        paste0("![", member_data$First.Name, " ", member_data$Last.Name, "](member_profiles/", member, ".png)"),
        "<br>",
        paste0("[{{< iconify bi mdi:email size=1.1em >}} ", member_data$Email, "](mailto:", member_data$Email, "){.btn .btn-outline-primary} "),
        # paste0("{{< iconify icon=\"mdi:web\" style=\"color: #007bff;\" >}} [", member_data$Website, "](", member_data$Website, ")"),
        # paste0("{{< iconify icon=\"mdi:github\" style=\"color: #007bff;\" >}} [", member_data$GitHub, "](https://github.com/", member_data$GitHub, ")"),
        # paste0("{{< iconify icon=\"academicons:researchgate\" style=\"color: #007bff;\" >}} [", member_data$ResearchGate, "](", member_data$ResearchGate, ")"),
        # paste0("{{< iconify icon=\"simpleicons:orcid\" style=\"color: #007bff;\" >}} [", member_data$ORCID, "](https://orcid.org/", member_data$ORCID, ")"),
        # paste0("{{< iconify icon=\"simpleicons:googlescholar\" style=\"color: #007bff;\" >}} [", member_data$GoogleScholar, "](", member_data$GoogleScholar, ")"),
        ":::",
        ":::{.column}",
        member_data$Institution, "<br>",
        member_data$Email, "<br>",
        ":::",
        "::::"
    ), fileConn)
    close(fileConn)
}

# sort the member list by first name
member_list <- member_list[order(member_list$First.Name), ]

# write the index file
index_page <- file("index.qmd", open = "w")
writeLines(c(
    "---",
    paste0("title: Member directory"),
    "---",
    ""
), index_page)
close(index_page)

for (i in 1:nrow(member_list)) {
    name <- paste0(member_list[i, ]$First.Name, "_", member_list[i, ]$Last.Name)
    index_page <- file("index.qmd", open = "a")
    writeLines(c(
        paste0("- [", member_list[i, ]$First.Name, " ", member_list[i, ]$Last.Name, "](./files/", name, ".html)")
    ), index_page)
    close(index_page)
}
