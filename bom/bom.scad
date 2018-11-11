

module bomq(code, desc, category) {
	echo(str(
    "BOM: { \"code\" : \"",
    code,
    "\", \"description\" : \"",
    desc,
    "\", \"categories\" : ",
    category,
    " }"
  ));
}

module bom(code, desc, category) {
}


module bomBN(x=1){
    for(i=[0,1,x]){
        bom(str("BoltXXX"), str("??"), ["Hardware"]);
        bom(str("Hammer NutXXX"), str("??"), ["Hardware"]);
    }
}
