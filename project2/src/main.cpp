#include <cstdlib>
#include <string>
#include <iostream>
#include <limits>
#include "database.h" 
#include <iomanip>

using namespace std;

// 메뉴판 출력 함수
void displayMenu() {
    cout << endl;
    cout << "----------------------------------------" << endl;
    cout << "          Database System Menu          " << endl;
    cout << "----------------------------------------" << endl;
    cout << "1. Sales Trends" << endl;
    cout << "2. Defective Part Tracking" << endl;
    cout << "3. Top Brands by Revenue" << endl;
    cout << "4. Top Brands by Unit Sales" << endl;
    cout << "5. Seasonal Sales Patterns" << endl;
    cout << "6. Dealer Inventory Efficiency" << endl;
    cout << "7. Supplier Coverage" << endl;
    cout << "0. Exit Program" << endl;
    cout << "----------------------------------------" << endl;
    cout << endl;
}

// MYSQL_BIND 구조체를 사용하여 사용자 입력을 처리하는 함수
int input_int(string msg, int def_val) {
    int val;
    cout << msg << " (default: \"" << def_val << "\" if you want to use the default value, enter -1): ";
    cin >> val;

    // 오류 예외처리문
    if (cin.fail()) {
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');
        return def_val;
    }
    
    if (val == -1) return def_val;
    return val;
}

// MYSQL_BIND 구조체를 사용하여 사용자 입력을 처리하는 함수2
string input_str(string msg, string def_val) {
    string val;

    cout << msg << " (default: '" << def_val << "' if you want to use the default value, enter .): ";
    cin >> val;
    
    if (val == ".")  return def_val;
    return val;
}


/*
void printResultTable(MYSQL_RES* res) {
    if (!res) return;

    int num_fields = mysql_num_fields(res);
    MYSQL_FIELD* fields = mysql_fetch_fields(res);
    
    // 1. Top border Line
    cout << "\n";
    for (int i = 0; i < num_fields; i++) {
        int len = fields[i].name ? strlen(fields[i].name) : 0;
        int width = (len > 10) ? len + 2 : 12;
        cout << string(width + 4, '-');
    }
    
    // 2. Print Headers
    cout << "\n| ";
    for (int i = 0; i < num_fields; i++) {
        int len = fields[i].name ? strlen(fields[i].name) : 0;
        int width = (len > 10) ? len + 2 : 12;
        cout << left << setw(width) << fields[i].name << " | ";
    }
    
    // 3. Middle border Line (Divider between Attributes and Tuples)
    cout << "\n";
    for (int i = 0; i < num_fields; i++) {
        int len = fields[i].name ? strlen(fields[i].name) : 0;
        int width = (len > 10) ? len + 2 : 12;
        cout << string(width + 4, '-');
    }
    cout << "\n";

    // 4. Print Tuples
    MYSQL_ROW row;
    while ((row = mysql_fetch_row(res))) {
        cout << "| ";
        for (int i = 0; i < num_fields; i++) {
            int len = fields[i].name ? strlen(fields[i].name) : 0;
            int width = (len > 10) ? len + 2 : 12;
            cout << left << setw(width) << (row[i] ? row[i] : "NULL") << " | ";
        }
        cout << "\n";
    }
    
    // 5. Bottom border Line
    for (int i = 0; i < num_fields; i++) {
        int len = fields[i].name ? strlen(fields[i].name) : 0;
        int width = (len > 10) ? len + 2 : 12;
        cout << string(width + 4, '-');
    }
    cout << "\n";
}

*/


// MYSQL_STMT 구조체를 사용하여 쿼리 결과를 표 형태로 출력하는 함수
void print_result(MYSQL_STMT* stmt) {
    MYSQL_RES* meta = mysql_stmt_result_metadata(stmt); if (meta == NULL) return;

    int cols = mysql_num_fields(meta);
    MYSQL_FIELD* fields = mysql_fetch_fields(meta);
MYSQL_BIND* bind_arr = new MYSQL_BIND[cols];
    string* str_data = new string[cols]; 
    
    char** temp_buf = new char*[cols];
    unsigned long* lengths = new unsigned long[cols];
    bool* is_null = new bool[cols];

    memset(bind_arr, 0, sizeof(MYSQL_BIND) * cols);
    // 초기화
    for (int i = 0; i < cols; i++) {
       
        int buf_len = 1000; 
        
        if (fields[i].length > 0) buf_len = fields[i].length + 1;

        temp_buf[i] = new char[buf_len];
        memset(temp_buf[i], 0, buf_len);

        bind_arr[i].buffer_type = MYSQL_TYPE_STRING;
        
        bind_arr[i].buffer = temp_buf[i];
        
        bind_arr[i].buffer_length = buf_len;
        
        bind_arr[i].length = &lengths[i];
        
        bind_arr[i].is_null = &is_null[i];

    }

    mysql_stmt_bind_result(stmt, bind_arr);
    mysql_stmt_store_result(stmt);

    int* w = new int[cols];

    //너비 계산 열에 대하여
    for (int i = 0; i < cols; i++) {
        
        string t_name = fields[i].name;
        
        int t_len = t_name.length();
        int d_len = fields[i].max_length;
        
        if (t_len > d_len) w[i] = t_len + 2; 

        else w[i] = d_len + 2;
        
    }

    cout << "\n+";


    // 테이블 위 테두리
    for (int i = 0; i < cols; i++) {
        string dash = "";
    
        for(int j=0; j<w[i]; j++) dash += "-";
        cout << dash << "+";
    }
    cout << "\n|";
    
    //열 이름
    for (int i = 0; i < cols; i++)  cout << " " << left << setw(w[i] - 1) << fields[i].name << "|";
    cout << "\n+";

    //구분 용 테두리
    for (int i = 0; i < cols; i++) {
        string dash = "";
       
        for(int j=0; j<w[i]; j++) dash += "-";
        cout << dash << "+";
    }
    cout << "\n";

    // 행 데이터
    while (mysql_stmt_fetch(stmt) == 0) {
        cout << "|";
       
        for (int i = 0; i < cols; i++) {
            if (is_null[i]) cout << " " << left << setw(w[i] - 1) << "NULL" << "|";
             
            
            else {
                str_data[i] = temp_buf[i]; 
                cout << " " << left << setw(w[i] - 1) << str_data[i].c_str() << "|";
            }
        }
        cout << "\n";
    }

    // 테이블 아래 테두리
    cout << "+";
    for (int i = 0; i < cols; i++) {
        string dash = "";
        
        for(int j=0; j<w[i]; j++) dash += "-";
        cout << dash << "+";
    }
    cout << "\n\n";

    delete[] w;
    for (int i = 0; i < cols; i++)  delete[] temp_buf[i];
    delete[] temp_buf;
    delete[] str_data;
    delete[] lengths;
    delete[] is_null;
    delete[] bind_arr;

    mysql_free_result(meta);
}


int getUserChoice() {
    int choice;
    cin >> choice;
    return choice;
}

// Query 1: Sales Trends Analysis
 void query1(MYSQL* conn) {
    int input_year = input_int("Enter the starting year for the query", 2024);

    string sql = "SELECT S.sale_year, S.sale_month, S.sale_week, B.name AS brand_name, C.gender, "
                 "CASE WHEN C.annual_income < 50000 THEN 'Low' "
                 "     WHEN C.annual_income BETWEEN 50000 AND 100000 THEN 'Middle' "
                 "     ELSE 'High' END AS income_range "
                 "FROM Sale S "
                 "JOIN Vehicle V ON S.VIN = V.VIN "
                 "JOIN Model_Detail MD ON V.model_ID = MD.model_ID "
                 "JOIN Model_Brand MB ON MD.name = MB.name "
                 "JOIN Brand B ON MB.brand_ID = B.brand_ID "
                 "JOIN Customer C ON S.customer_ID = C.customer_ID "
                 "WHERE S.sale_year >= ? "
                 "GROUP BY S.sale_year, S.sale_month, S.sale_week, B.name, C.gender, income_range "
                 "ORDER BY S.sale_year DESC, S.sale_month ASC;";

    MYSQL_STMT* stmt = mysql_stmt_init(conn);
    mysql_stmt_prepare(stmt, sql.c_str(), sql.length());

    MYSQL_BIND bind_in[1]{};
    bind_in[0].buffer_type = MYSQL_TYPE_LONG;
    bind_in[0].buffer = &input_year;

    mysql_stmt_bind_param(stmt, bind_in);
    mysql_stmt_execute(stmt);

    print_result(stmt);

    mysql_stmt_close(stmt);
}


// Query 2: Defective Part Tracking
void query2(MYSQL* conn) {
    string supplier_name = input_str("Enter Supplier Name", "Getrag_Transmissions");
    string part_category = input_str("Enter Part Category", "Transmission");
    string start_date = input_str("Enter Start Date (YYYY-MM-DD)", "2024-01-01");
    string end_date = input_str("Enter End Date (YYYY-MM-DD)", "2026-12-31");

    string sql = "SELECT V.VIN, C.name AS customer_name, C.phone AS customer_phone, C.address AS customer_address, "
                 "       P.name AS part_name, Su.name AS supplier_name, "
                 "       CONCAT(MP.prod_year, '-', LPAD(MP.prod_month, 2, '0'), '-', LPAD(MP.prod_day, 2, '0')) AS production_date "
                 "FROM Manufacturedpart MP "
                 "JOIN Part P ON MP.part_ID = P.part_ID "
                 "JOIN Vehicle V ON MP.VIN = V.VIN "
                 "JOIN Supply Sp ON Sp.model_ID = V.model_ID AND Sp.part_ID = MP.part_ID "
                 "JOIN Supplier Su ON Sp.supplier_ID = Su.supplier_ID "
                 "JOIN Sale S ON V.VIN = S.VIN "
                 "JOIN Customer C ON S.customer_ID = C.customer_ID "
                 "WHERE Su.name = ? "
                 "  AND P.category = ? "
                 "  AND STR_TO_DATE(CONCAT(MP.prod_year, '-', LPAD(MP.prod_month, 2, '0'), '-', LPAD(MP.prod_day, 2, '0')), '%Y-%m-%d') "
                 "      BETWEEN ? AND ? "
                 "ORDER BY production_date ASC;";

    MYSQL_STMT* stmt = mysql_stmt_init(conn);
    mysql_stmt_prepare(stmt, sql.c_str(), sql.length());

    MYSQL_BIND bind_in[4]{};

    bind_in[0].buffer_type = MYSQL_TYPE_STRING;
    bind_in[0].buffer = (char*)supplier_name.c_str();
    bind_in[0].buffer_length = supplier_name.length();



    bind_in[1].buffer_type = MYSQL_TYPE_STRING;
    bind_in[1].buffer = (char*)part_category.c_str();
    bind_in[1].buffer_length = part_category.length();



    bind_in[2].buffer_type = MYSQL_TYPE_STRING;
    bind_in[2].buffer = (char*)start_date.c_str();
    bind_in[2].buffer_length = start_date.length();



    bind_in[3].buffer_type = MYSQL_TYPE_STRING;
    bind_in[3].buffer = (char*)end_date.c_str();
    bind_in[3].buffer_length = end_date.length();



    mysql_stmt_bind_param(stmt, bind_in);
    mysql_stmt_execute(stmt);

    print_result(stmt);

    mysql_stmt_close(stmt);
}


// Query 3: Top Brands by Revenue
void query3(MYSQL* conn) {
    int input_year = input_int("Enter the year for revenue analysis", 2025);

    string sql = "WITH RankedBrands AS ( "
                 "    SELECT B.name AS brand_name, "
                 "           SUM(S.price) AS total_revenue, "
                 "           DENSE_RANK() OVER (ORDER BY SUM(S.price) DESC) AS rnk "
                 "    FROM Sale S "
                 "    JOIN Vehicle V ON S.VIN = V.VIN "
                 "    JOIN Model_Detail MD ON V.model_ID = MD.model_ID "
                 "    JOIN Model_Brand MB ON MD.name = MB.name "
                 "    JOIN Brand B ON MB.brand_ID = B.brand_ID "
                 "    WHERE S.sale_year = ? "
                 "    GROUP BY B.brand_ID, B.name "
                 ") "
                 "SELECT brand_name, total_revenue "
                 "FROM RankedBrands "
                 "WHERE rnk <= 2;";

    MYSQL_STMT* stmt = mysql_stmt_init(conn);
    mysql_stmt_prepare(stmt, sql.c_str(), sql.length());

    MYSQL_BIND bind_in[1]{};
    bind_in[0].buffer_type = MYSQL_TYPE_LONG;
    bind_in[0].buffer = &input_year;

    mysql_stmt_bind_param(stmt, bind_in);
    mysql_stmt_execute(stmt);

    print_result(stmt);

    mysql_stmt_close(stmt);
}

// Query 4: Top Brands by Unit Sales
void query4(MYSQL* conn) {
    int input_year = input_int("Enter the year for unit sales analysis", 2025);

    string sql = "WITH RankedBrands AS ( "
                 "    SELECT B.name AS brand_name, "
                 "           SUM(S.quantity) AS total_units_sold, "
                 "           DENSE_RANK() OVER (ORDER BY SUM(S.quantity) DESC) AS rnk "
                 "    FROM Sale S "
                 "    JOIN Vehicle V ON S.VIN = V.VIN "
                 "    JOIN Model_Detail MD ON V.model_ID = MD.model_ID "
                 "    JOIN Model_Brand MB ON MD.name = MB.name "
                 "    JOIN Brand B ON MB.brand_ID = B.brand_ID "
                 "    WHERE S.sale_year = ? "
                 "    GROUP BY B.brand_ID, B.name "
                 ") "
                 "SELECT brand_name, total_units_sold "
                 "FROM RankedBrands "
                 "WHERE rnk <= 2;";

    MYSQL_STMT* stmt = mysql_stmt_init(conn);
    mysql_stmt_prepare(stmt, sql.c_str(), sql.length());

    MYSQL_BIND bind_in[1]{};
    bind_in[0].buffer_type = MYSQL_TYPE_LONG;
    bind_in[0].buffer = &input_year;

    mysql_stmt_bind_param(stmt, bind_in);
    mysql_stmt_execute(stmt);

    print_result(stmt);

    mysql_stmt_close(stmt);
}

// Query 5: Seasonal Sales Patterns
void query5(MYSQL* conn) {
    string input_style = input_str("Enter vehicle style", "Convertible");

    string sql = "WITH MonthlySales AS ( "
                 "    SELECT S.sale_month, "
                 "           COUNT(*) AS monthly_sales, "
                 "           DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk "
                 "    FROM Sale S "
                 "    JOIN Vehicle V ON S.VIN = V.VIN "
                 "    JOIN Model_Detail MD ON V.model_ID = MD.model_ID "
                 "    WHERE MD.styles = ? " 
                 "    GROUP BY S.sale_month "
                 ") "
                 "SELECT sale_month, monthly_sales "
                 "FROM MonthlySales "
                 "WHERE rnk = 1;";

    MYSQL_STMT* stmt = mysql_stmt_init(conn);
    mysql_stmt_prepare(stmt, sql.c_str(), sql.length());

    MYSQL_BIND bind_in[1]{};
    bind_in[0].buffer_type = MYSQL_TYPE_STRING;
    bind_in[0].buffer = (char*)input_style.c_str();
    bind_in[0].buffer_length = input_style.length();

    mysql_stmt_bind_param(stmt, bind_in);
    mysql_stmt_execute(stmt);

    print_result(stmt);

    mysql_stmt_close(stmt);
}

// Query 6: Dealer Inventory Efficiency
void query6(MYSQL* conn) {
    int input_rank = input_int("Enter rank threshold for inefficient dealers", 1);

    string sql = "WITH Dealertobefired AS ( "
                 "    SELECT D.dealer_ID, "
                 "           D.name AS dealer_name, "
                 "           ROUND( AVG( DATEDIFF( "
                 "               STR_TO_DATE(CONCAT(S.sale_year, '-', S.sale_month, '-', S.sale_day), '%Y-%m-%d'), "
                 "               STR_TO_DATE(CONCAT(I.arrival_year, '-', I.arrival_month, '-', I.arrival_day), '%Y-%m-%d') "
                 "           )), 1) AS avg_days, "
                 "           DENSE_RANK() OVER ( "
                 "               ORDER BY AVG(DATEDIFF( "
                 "                   STR_TO_DATE(CONCAT(S.sale_year, '-', S.sale_month, '-', S.sale_day), '%Y-%m-%d'), "
                 "                   STR_TO_DATE(CONCAT(I.arrival_year, '-', I.arrival_month, '-', I.arrival_day), '%Y-%m-%d') "
                 "               )) DESC "
                 "           ) AS rnk "
                 "    FROM Sale S "
                 "    JOIN Inventory I ON S.VIN = I.VIN "
                 "    JOIN Dealer D ON S.dealer_ID = D.dealer_ID "
                 "    GROUP BY D.dealer_ID, D.name "
                 ") "
                 "SELECT dealer_ID, dealer_name, avg_days "
                 "FROM Dealertobefired "
                 "WHERE rnk <= ?;";

    MYSQL_STMT* stmt = mysql_stmt_init(conn);
    mysql_stmt_prepare(stmt, sql.c_str(), sql.length());

    MYSQL_BIND bind_in[1]{};
    bind_in[0].buffer_type = MYSQL_TYPE_LONG;
    bind_in[0].buffer = &input_rank;

    mysql_stmt_bind_param(stmt, bind_in);
    mysql_stmt_execute(stmt);

    print_result(stmt);

    mysql_stmt_close(stmt);
}

// Query 7: Supplier Coverage
void query7(MYSQL* conn) {
    int input_rank = input_int("Enter rank threshold for supplier coverage", 1);

    string sql = "WITH SupplierCoverage AS ( "
                 "    SELECT Su.supplier_ID, "
                 "           Su.name AS supplier_name, "
                 "           COUNT(DISTINCT S.model_ID) AS count, "
                 "           DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT S.model_ID) DESC) AS rnk "
                 "    FROM Supplier Su "
                 "    JOIN Supply S ON Su.supplier_ID = S.supplier_ID "
                 "    GROUP BY Su.supplier_ID, Su.name "
                 ") "
                 "SELECT supplier_ID, supplier_name, count "
                 "FROM SupplierCoverage "
                 "WHERE rnk <= ?;";

    MYSQL_STMT* stmt = mysql_stmt_init(conn);
    mysql_stmt_prepare(stmt, sql.c_str(), sql.length());

    MYSQL_BIND bind_in[1]{};
    bind_in[0].buffer_type = MYSQL_TYPE_LONG;
    bind_in[0].buffer = &input_rank;

    mysql_stmt_bind_param(stmt, bind_in);
    mysql_stmt_execute(stmt);

    print_result(stmt);

    mysql_stmt_close(stmt);
}


int main() {
    const char* host = std::getenv("DB_HOST");
    const char* user = std::getenv("DB_USER");
    const char* password = std::getenv("DB_PASSWORD");
    if (!user || !*user || !password) {
        std::cerr << "Set DB_USER and DB_PASSWORD before running.\n";
        return 1;
    }

    MYSQL* conn = mysql_init(nullptr);
    if (!conn) {
        std::cerr << "Could not initialize the MySQL client.\n";
        return 1;
    }
    if (!mysql_real_connect(conn, host && *host ? host : "127.0.0.1",
                            user, password, "cse4110_vehicle_sales", 3306, nullptr, 0)) {
        std::cerr << "Database connection error: " << mysql_error(conn) << '\n';
        mysql_close(conn);
        return 1;
    }

    int choice = 0;
    
    displayMenu();
    

    // 사용자로부터 입력을 받아 해당 쿼리를 실행하는 루프
    while (true) {
        cout << "\nEnter your choice: \n";

        choice = getUserChoice();
        

        switch (choice) {
            
            case 0:
                cout << "exit!\n";
                mysql_close(conn);
                return 0;
                break;

            case 1:
                cout << "\n[Running] Query 1...\n";
                query1(conn);
                break;
            
            case 2:
                cout << "\n[Running] Query 2...\n";
                query2(conn);
                break;
        
            case 3:
                cout << "\n[Running] Query 3...\n";
                query3(conn);
                break;
                
            case 4:
                cout << "\n[Running] Query 4...\n";
                query4(conn );
                break;
            
            case 5:
                cout << "\n[Running] Query 5...\n";
                query5(conn);
                break;
        
            case 6:
                cout << "\n[Running] Query 6...\n";
                query6(conn);
                break;
    
            case 7:
                cout << "\n[Running] Query 7...\n";
                query7(conn);
                break;

            default:
                cout << "Invalid choice. Select between 0 and 7.\n";
                break;
        }
    }

    mysql_close(conn);

    return 0;
}