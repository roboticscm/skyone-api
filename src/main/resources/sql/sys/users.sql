-- Module: System (sys)
-- Section: Human or org (hoo)
-- Function Description: Get owner org id of the user
-- Params:
--  _user_id:
-- _org_type: 10000 (company), 1000 (branch), 100 (department), 10 (group)
--  _include_deleted: Include deleted record
--  _include_disabled: Include disabled record
create or replace function sys_get_owner_id_of_user(_user_id bigint, _org_type smallint, _include_deleted bool, _include_disabled bool)
returns text as $$
declare 
	_query text;
	ret_val text;
begin
_query = format('
select array_to_string(array(
select ono.id
from owner_org ono
where ono.type = %L
	and ono.id in (' || sys_get_all_parent_org_ids((select default_owner_org_id from users where id = _user_id), _include_deleted, _include_disabled) || ')
),%L)', _org_type, ',');
execute _query into ret_val;
return  ret_val;
end;
$$ language plpgsql called on null input;
