# Snowflake UDF & UDTF Examples

Welcome to the **Snowflake Season of Build 2025** workshop! This repository is part of the workshop series for Build 2025. 

Where we provide hands-on examples of User-Defined Functions (UDFs) and User-Defined Table Functions (UDTFs) in Snowflake. You will create and use custom functions in Snowflake to extend SQL capabilities and perform complex data transformations. Learning how to build both scalar functions (UDFs) and table-returning functions (UDTFs) using SQL and Python.

## 📋 Prerequisites

- Access to a Snowflake account
- Basic understanding of SQL
- Familiarity with Python (helpful but not required)
- A database with sample sales data (or use the provided examples to create your own)

## 🚀 What You'll Learn

- **User-Defined Functions (UDFs)**: Create custom scalar functions that process individual values
- **User-Defined Table Functions (UDTFs)**: Build functions that return entire result sets
- **Python UDFs**: Leverage Python's capabilities within Snowflake
- **SQL UDTFs**: Create efficient table functions using pure SQL
- **Practical Applications**: Combine UDFs and UDTFs to solve real-world data problems

## 📁 Repository Contents

- `udf-udtf.sql` - Complete SQL script with all examples and demonstrations
- `README.md` - This file

## 🔧 Examples Included

### 1. Python UDF: RoundToWhole
A simple Python-based UDF that rounds floating-point numbers to the nearest whole number.

```sql
CREATE OR REPLACE FUNCTION RoundToWhole(value FLOAT)
    RETURNS NUMBER
    LANGUAGE PYTHON
    RUNTIME_VERSION = '3.13'
    HANDLER = 'round_value'
```

**Use Case**: Standardizing currency values or simplifying numeric displays.

### 2. SQL UDTF: AvgSalesPerUnit
A SQL-based table function that calculates the average sales amount per unit sold.

```sql
CREATE OR REPLACE FUNCTION AvgCostPerUnitProductPerSale()
    RETURNS TABLE (...)
    LANGUAGE SQL
```

**Use Case**: Analyzing pricing of each unit of a product for each sale.

### 3. Combined Example
The workshop demonstrates how to combine both functions to:
- Create a view with rounded avg cost per product per sale
- Join the results with a products table
- Generate a comprehensive avg pricing from all sales table

## 🎓 How to Use

1. **Set up your Snowflake environment**
   - Ensure you have a database and warehouse configured
   - Create or use an existing schema

2. **Prepare sample data**
   - The script expects `SALES` and `PRODUCTS` tables
   - Modify the script if your table structures differ

3. **Run the examples**
   - Open `udf-udtf.sql` in your Snowflake worksheet
   - Execute the commands step-by-step
   - Observe the output at each stage

4. **Experiment**
   - Modify the functions to suit your data
   - Try creating your own UDFs and UDTFs
   - Combine multiple functions for complex transformations

## 💡 Key Concepts

### UDF vs UDTF
- **UDF (User-Defined Function)**: Returns a single value for each input row
- **UDTF (User-Defined Table Function)**: Returns a table (multiple rows and columns)

### SQL vs Python
- **SQL UDTFs**: Generally more efficient, better for set-based operations
- **Python UDFs**: More flexible, useful for complex logic or external library integration


## 📚 Additional Resources

- [Snowflake UDF Documentation](https://docs.snowflake.com/en/sql-reference/user-defined-functions)


## 📝 License

See the [LICENSE](LICENSE) file for details.

---

**Happy Building! ❄️**