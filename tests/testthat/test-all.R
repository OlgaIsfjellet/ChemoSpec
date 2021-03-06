
### Unit tests for ChemoSpec

context("cleanArgs") #####

tf <- function(func = "read.table", ...) {
	args <- as.list(match.call())[-1]
	args <- .cleanArgs(args, func)
	return(args)
}

# cleanArgs strips args intended for files2SpectraObject and list.files
# when called with read.table as an argument
test_that("cleanArgs strips list.files args, keeps read.table args", {
  args <- tf(x = 1:20, y = LETTERS[1:5], z = 0.78,
    header = TRUE, gr.crit = ".", recursive = TRUE,
	sep = ",", path = ".", pattern = "xyz",
	full.names = TRUE, out.file = "myfile", func = "read.table")
  expect_true(length(args) == 2L)
  expect_true("header" %in% names(args))
  expect_true("sep" %in% names(args))
  expect_false("recursive" %in% names(args))
  expect_false("gr.crit" %in% names(args))
})

# cleanArgs strips args intended for files2SpectraObject and read.table
# when called with list.files as an argument
test_that("cleanArgs strips read.table args, keeps list.files args", {
  args <- tf(x = 1:20, y = LETTERS[1:5], z = 0.78,
    header = TRUE, gr.crit = ".", recursive = TRUE,
	sep = ",", path = ".", pattern = "xyz",
	full.names = TRUE, out.file = "myfile", func = "list.files")
  expect_true(length(args) == 2L)
  expect_true("recursive" %in% names(args))
  expect_true("path" %in% names(args))
  expect_false("header" %in% names(args))
  expect_false("gr.crit" %in% names(args))
})
