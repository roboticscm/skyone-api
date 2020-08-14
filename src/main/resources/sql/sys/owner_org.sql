create or replace function sys_is_department_assigned_for_user(_dep_id bigint, _user_id bigint, _include_deleted bool, _include_disabled bool)
returns bool as $$
declare 
	_query TEXT;
	ret_val bool;
begin
if is_system_admin_by_user_id(_user_id, false, false) = true then
	ret_val = true;
else
_query = format('
select exists(select dep.id
from owner_org dep
inner join menu_org mo on mo.org_id = dep.id and ' || get_deleted_cond_str('mo', _include_deleted) || '
	and ' || get_disabled_cond_str('mo', _include_disabled) || '	
inner join role_detail rd on rd.menu_org_id = mo.id and ' || get_deleted_cond_str('rd', _include_deleted) || '
	and ' || get_disabled_cond_str('rd', _include_disabled) || '	
inner join role r on r.id = rd.role_id and ' || get_deleted_cond_str('r', _include_deleted) || '
	and ' || get_disabled_cond_str('r', _include_disabled) || '	
inner join assignment_role ar on ar.role_id = r.id and ar.user_id = %L and ' || get_deleted_cond_str('ar', _include_deleted) || '
	and ' || get_disabled_cond_str('ar', _include_disabled) || '	
where dep.id = %L and ' || get_deleted_cond_str('dep', _include_deleted) || '
	and ' || get_disabled_cond_str('dep', _include_disabled) || '		
	limit 1
)', _user_id, _dep_id);

execute _query into ret_val;
end if;
return  ret_val;
end;
$$ language plpgsql called on null input;



-- Module: System (sys)
-- Section: Owner Org (ono)
-- Function Description: Get the first assigned role department id by user id
-- Params:
--  _user_id
--  _include_deleted: Include deleted record
--  _include_disabled: Include disabled record
create or replace function sys_get_first_roled_department_id_by_user_id(_user_id bigint, _include_deleted bool, _include_disabled bool)
returns text as $$
declare 
	_query TEXT;
	ret_val TEXT;
begin
_query = format('
select array_to_string(array(select dep.id
from owner_org dep
inner join menu_org mo on mo.org_id = dep.id and ' || get_deleted_cond_str('mo', _include_deleted) || '
	and ' || get_disabled_cond_str('mo', _include_disabled) || '	
inner join role_detail rd on rd.menu_org_id = mo.id and ' || get_deleted_cond_str('rd', _include_deleted) || '
	and ' || get_disabled_cond_str('rd', _include_disabled) || '	
inner join role r on r.id = rd.role_id and ' || get_deleted_cond_str('r', _include_deleted) || '
	and ' || get_disabled_cond_str('r', _include_disabled) || '	
inner join assignment_role ar on ar.role_id = r.id and ar.user_id = %L and ' || get_deleted_cond_str('ar', _include_deleted) || '
	and ' || get_disabled_cond_str('ar', _include_disabled) || '	
where ' || get_deleted_cond_str('dep', _include_deleted) || '
	and ' || get_disabled_cond_str('dep', _include_disabled) || '		
	order by dep.sort, dep.name, dep.created_date
	limit 1
), %L)', _user_id, ',');

execute _query into ret_val;
return  ret_val;
end;
$$ language plpgsql called on null input;




-- Module: System (sys)
-- Section: Owner Org (ono)
-- Function Description: Get all parent org ids
-- Params:
--  _id
--  _include_deleted: Include deleted record
--  _include_disabled: Include disabled record
create or replace function sys_get_all_parent_org_ids(_id bigint, _include_deleted bool, _include_disabled bool)
returns text as $$
declare
	ret_val text;
	_query text;
begin
_query = format('with recursive org as (
    select parent_id
    from owner_org
    where id = %L 
    	and '|| get_deleted_cond_str(null, _include_deleted) || ' 
	  	and ' || get_disabled_cond_str(null, _include_deleted) || ' 
    union
    select oo.parent_id
    from owner_org oo 
    inner join org o on o.parent_id = oo.id
    where ' || get_deleted_cond_str('oo', _include_deleted) || '
	  	and ' || get_disabled_cond_str(null, _include_deleted) || '
)

select array_to_string(array(select parent_id
from org), %L)', _id, ',');

execute _query into ret_val;

if ret_val = '' then
	ret_val = _id;
else 
	ret_val = _id || ',' || ret_val;
end if;

return  ret_val;
end;
$$ language plpgsql called on null input;

