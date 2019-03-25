CKEDITOR.editorConfig = function (config) {
  config.height = 60;
  config.toolbarCanCollapse = true;
  config.toolbar = "MyToolbar";
  config.toolbar_MyToolbar =
    [
      {name: "clipboard", items: ["Cut", "Copy", "Paste", "PasteText",
        "PasteFromWord", "-", "Undo", "Redo"]},
      {name: "editing", items: ["Find", "Replace", "-", "SelectAll", "-",
        "Scayt"]},
      {
        name: "insert", items: ["Image", "Table", "HorizontalRule", "Smiley",
          "SpecialChar", "PageBreak", "Iframe"]
      },
      {name: "basicstyles", items: ["Bold", "Italic", "Strike", "-",
        "RemoveFormat"]},
      {name: "tools", items: ["Maximize", "-", "About"]}
    ];
};
