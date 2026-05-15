require("full-border"):setup {
    type = ui.Border.PLAIN
}

require("inc-search")

require("mime-ext.local"):setup {
    with_exts = {
        heic = "image/heic",
    },
    fallback_file1 = true,
}
