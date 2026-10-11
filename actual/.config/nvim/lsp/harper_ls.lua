-- https://writewithharper.com/docs/integrations/language-server#Configuration
return {
  settings = {
    ["harper_ls"] = {
      linters = {
        SpellCheck = true,
        SpelledNumbers = false,
        AnA = true,
        SentenceCapitalization = true,
        UnclosedQuotes = true,
        WrongApostrophe = false,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        CorrectNumberSuffix = true,
      },
      markdown = {
        IgnoreLinkTitle = true,
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
    },
  },
}
