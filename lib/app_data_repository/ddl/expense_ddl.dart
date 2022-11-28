class IncomeHeaderDDL {
  String tableName = 'header';
  String idColumn = 'id';
  String typeColumn = 'type';
  String nameColumn = 'name';
  String descColumn = 'desc';
  String amountColumn = 'amount';
  String flag1Column = 'flag1';
  String flag2Column = 'flag2';
}

class IncomeLinesDDL {
  String tableName = 'expense_lines';
  String idColumn = 'id';
  String subAmountColumn = 'sub_amount';
  String duedateColumn = 'due_date';
  String headerIdColumn = 'header_id';
  String descColumn = 'desc';
}

class ExpenseLinesDDL {
  String tableName = 'expense_lines';
  String idColumn = 'id';
  String subAmountColumn = 'sub_amount';
  String duedateColumn = 'due_date';
  String headerIdColumn = 'header_id';
  String descriptionColumn = 'desc';
}

class ExpenseHeaderDDL {
  String tableName = 'expense_header';
  String idColumn = 'id';
  String expenseNameColumn = 'expense_name';
  String expenseDescColumn = 'desc';
  String amountColumn = 'amount';
  String inBankColumn = 'in_bank_flag';
  String startDateColumn = 'start_date';
  String endDateColumn = 'end_date';
  String categoryIdColumn = 'exp_cat_id';
}

class ExpenseCategoryDDL {
  String tableName = 'expense_category';
  String idColumn = 'id';
  String nameColumn = 'category_name';
  String instantColumn = 'instant_flag';
}
