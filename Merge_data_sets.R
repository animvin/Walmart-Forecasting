library(sqldf)
library(readr)

features = read_csv("E:/Courses/5671-DataMiningBI/Project/retail-data-analytics/Features data set.csv")
sales = read_csv("E:/Courses/5671-DataMiningBI/Project/retail-data-analytics/sales data-set.csv")
stores = read_csv("E:/Courses/5671-DataMiningBI/Project/retail-data-analytics/stores data-set.csv")


sales$IsHoliday = ifelse(sales$IsHoliday == "TRUE",1,0)

sales_weekly = sqldf("select Store,Date,sum(Weekly_Sales) 'Sales' from sales group by Store,Date")


joined = sqldf("select f.Store,s.Sales,f.Date,Temperature,Fuel_Price,MarkDown1,MarkDown2,MarkDown3,
                MarkDown4,MarkDown5,CPI,Unemployment,IsHoliday from features f left outer join sales_weekly s 
                on (f.Store=s.Store) and (f.Date=s.Date)")

final = sqldf("select f.Store,Sales,Date,Temperature,Fuel_Price,MarkDown1,MarkDown2,MarkDown3,
                MarkDown4,MarkDown5,CPI,Unemployment,IsHoliday,Type,Size from joined f join stores s 
                on (f.Store=s.Store)")


write.csv(final,"E:/Courses/5671-DataMiningBI/Project/retail-data-analytics/merged.csv")
