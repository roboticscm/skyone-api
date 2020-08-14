-- Module: System (sys)
-- Section: Menu (mnu)
-- Function Description: Get the first assigned role menu path by user id and department id
-- Params:
--  _user_id
--  _dep_id: Department ID
--  _include_deleted: Include deleted record
--  _include_disabled: Include disabled record
create or replace function sys_get_first_roled_menu_path_by_user_id_and_dep_id(_user_id bigint,  _dep_id bigint, _include_deleted bool, _include_disabled bool)
returns text as $$
declare 
	_query TEXT;
	ret_val TEXT;
begin
if is_system_admin_by_user_id(_user_id, false, false) = true then
_query = format('
select array_to_string(array(select m.path 
from menu m
inner join menu_org mo on mo.menu_id = m.id and mo.org_id = %L and ' || get_deleted_cond_str('mo', _include_deleted) || '
	and ' || get_disabled_cond_str('mo', _include_disabled) || '
where m.path != %L and m.path is not null
order by m.sort, m.name, m.created_date	
limit 1
), %L)', _dep_id, '', ',');
else
_query = format('
select array_to_string(array(select m.path 
from menu m
inner join menu_org mo on mo.menu_id = m.id and mo.org_id = %L and ' || get_deleted_cond_str('mo', _include_deleted) || '
	and ' || get_disabled_cond_str('mo', _include_disabled) || '
inner join role_detail rd on rd.menu_org_id = mo.id and ' || get_deleted_cond_str('rd', _include_deleted) || '
	and ' || get_disabled_cond_str('rd', _include_disabled) || '
inner join role r on r.id = rd.role_id and ' || get_deleted_cond_str('r', _include_deleted) || '
	and ' || get_disabled_cond_str('r', _include_disabled) || '
inner join assignment_role ar on ar.role_id = r.id and ar.user_id = %L and ' || get_deleted_cond_str('ar', _include_deleted) || '
	and ' || get_disabled_cond_str('ar', _include_disabled) || '
where ' || get_deleted_cond_str('m', _include_deleted) || '
	and ' || get_disabled_cond_str('m', _include_disabled) || '
	and m.path != %L and m.path is not null
order by m.sort, m.name, m.created_date
	limit 1
), %L)', _dep_id, _user_id, '', ',');
end if;
execute _query into ret_val;
return  ret_val;
end;
$$ language plpgsql called on null input;