create PROCEDURE Select_Routines
    @db_name nvarchar(255) = NULL
AS
BEGIN
    declare @result_table table(
        DatabaseName nvarchar(255),
        SchemaName NVARCHAR(255),
        Routine_Name NVARCHAR(255),
        ROUTINE_TYPE NVARCHAR(15),
        Parameters NVARCHAR(max),
        Return_Type nvarchar(63)
    );
    declare @sql_query nvarchar(max);

    IF @db_name is not NULL
    begin 
        set @sql_query = '
            SELECT r.SPECIFIC_CATALOG  Database_name,
                    r.SPECIFIC_SCHEMA SchemaName,
                    r.Routine_Name,
                    r.ROUTINE_TYPE,
                    (select string_agg(concat(p.PARAMETER_NAME, '' '', p.Data_Type, ''('' + 
                                            case when p.CHARACTER_MAXIMUM_LENGTH = -1 then ''max''
                                            else cast(p.CHARACTER_MAXIMUM_LENGTH as nvarchar)
                                            end
                                            + '')''), 
                                        '', '')
                        from ' + QUOTENAME(@db_name) + '.INFORMATION_SCHEMA.PARAMETERS p
                        where p.IS_RESULT = ''NO'' and 
                            p.SPECIFIC_CATALOG = r.SPECIFIC_CATALOG and
                            p.SPECIFIC_SCHEMA = r.SPECIFIC_SCHEMA and 
                            r.SPECIFIC_NAME = p.SPECIFIC_NAME
                    ) as Parameters,
                    concat(r.Data_Type, ''('' + 
                        case when r.CHARACTER_MAXIMUM_LENGTH = -1
                        then ''max''
                        else cast(r.CHARACTER_MAXIMUM_LENGTH as nvarchar)
                        end) as Return_Type
            FROM ' + QUOTENAME(@db_name) + '.INFORMATION_SCHEMA.ROUTINES r';
            
        insert into @result_table
        EXEC(@sql_query)
    end
    else 
    begin 
        DECLARE @i int = 1;
        declare @count int = (select count(1) from sys.databases);

        while @i <= @count
        begin
            with cte as(
                select name, ROW_NUMBER() OVER (order BY name) as rnk
                from sys.databases
            ) 
            select @db_name = name 
            from cte where rnk = @i;
            
            
            set @sql_query = '
                SELECT r.SPECIFIC_CATALOG  Database_name,
                        r.SPECIFIC_SCHEMA SchemaName,
                        r.Routine_Name,
                        r.ROUTINE_TYPE,
                        (select string_agg(concat(p.PARAMETER_NAME, '' '', p.Data_Type, ''('' + 
                                                case when p.CHARACTER_MAXIMUM_LENGTH = -1 then ''max''
                                                else cast(p.CHARACTER_MAXIMUM_LENGTH as nvarchar)
                                                end
                                                + '')''), 
                                            '', '')
                            from ' + QUOTENAME(@db_name) + '.INFORMATION_SCHEMA.PARAMETERS p
                            where p.IS_RESULT = ''NO'' and 
                                p.SPECIFIC_CATALOG = r.SPECIFIC_CATALOG and
                                p.SPECIFIC_SCHEMA = r.SPECIFIC_SCHEMA and 
                                r.SPECIFIC_NAME = p.SPECIFIC_NAME
                        ) as Parameters,
                        concat(r.Data_Type, ''('' + 
                            case when r.CHARACTER_MAXIMUM_LENGTH = -1
                            then ''max''
                            else cast(r.CHARACTER_MAXIMUM_LENGTH as nvarchar)
                            end) as Return_Type
                FROM ' + QUOTENAME(@db_name) + '.INFORMATION_SCHEMA.ROUTINES r';

            insert into @result_table
            EXEC(@sql_query)
            set @i = @i + 1;
        end;
    end;

    select * from @result_table;
END;

GO

exec Select_Routines