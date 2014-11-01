Office.create(
  name: "Department Of Computer Science",
  email: "arnelle@gmail.com",
  password: "password",
  admin: true
);

Office.create(
  name: "Accounting Office",
  email: "accounting@gmail.com",
  password: "password"
)

Office.create(
  name: "Dean's Office",
  email: "dean@gmail.com",
  password: "password"
)

DocumentType.create(
  name: "Purchase Request",
  route: "1,2,3"
)

DocumentType.create(
  name: "Letter",
  route: "1,3"
)

DocumentType.create(
  name: "Leave",
  route: "2,3"
)