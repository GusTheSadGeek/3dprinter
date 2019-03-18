

module bom(code, desc, category, link="X") {
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
        ", \"link\" : \"",
        link,
        "\" }"));
    }
}
module bomq(code, desc, category, link="X") {
}


module bomBN(x=1){
    for(i=[0,1,x]){
        bom(str("BoltXXX"), str("??"), ["Hardware"]);
        bom(str("Hammer NutXXX"), str("??"), ["Hardware"]);
    }
}
