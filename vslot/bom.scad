

module bomq(code, desc, category, link="X") {
    if (link == "X") {
        echo(str(
        "BOM: { \"code\" : \"",
        code,
        "\", \"description\" : \"",
        desc,
        "\", \"categories\" : ",
        category,
        " }"));
    }
    else
    {
        echo(str(
        "BOM: { \"code\" : \"",
        code,
        "\", \"description\" : \"",
        desc,
        "\", \"categories\" : ",
        category,
        "\", \"link\" : ",
        link,
        " }"));
    }
}

module bom(code, desc, category) {
}
