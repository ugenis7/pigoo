library(dplyr)

pigoo <- readr::read_csv("input/pigoo.csv") %>%
	select(orgope, mpio_inegi, estado) %>%
	arrange(estado, mpio_inegi)

pigoo$orgope <- stringr::str_remove(pigoo$orgope, ",")
pigoo$orgope <- stringr::str_remove(pigoo$orgope, ",")

readr::write_csv(pigoo, "input/pigoo.csv")
