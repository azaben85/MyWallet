class ExpenseLinesDDL {
  String tableName = 'expense_lines';
  String idColumn = 'id';
  String subAmountColumn = 'sub_amount';
  String duedateColumn = 'due_date';
  String headerIdColumn = 'header_id';
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
