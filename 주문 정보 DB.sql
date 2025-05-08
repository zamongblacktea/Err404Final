SELECT 
  os.*,
  si.shop_name,si.shop_addr1,si.shop_addr2,
  mi.menu_name,mi.menu_price
FROM  order_status  os inner join shop_info si on os.shop_idx=si.shop_idx
                       inner join menu_info mi on os.menu_idx=mi.menu_idx
where order_status='조리대기'  

insert into 
