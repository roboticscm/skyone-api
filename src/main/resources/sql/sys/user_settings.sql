create or replace function sys_get_value_of_user_settings(_user_id bigint, _menu_path text, _control_id text, _key text)
returns text as $$
declare 
	_query text;
	ret_val text;
begin
_query = format('
select array_to_string(array(
select value 
from user_settings
where user_id = %L
	and menu_path=%L
	and control_id=%L
	and key=%L
),%L)
', _user_id, _menu_path, _control_id, _key, ',');
execute _query into ret_val;
return  ret_val;
end;
$$ language plpgsql called on null input;