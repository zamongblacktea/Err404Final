import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("RiderVo")
public class RiderVo {
	int rider_idx;
	String rider_id;
	String rider_pwd;	
	String rider_name;	
	String rider_email;	
	String rider_ip;	
	String rider_regdate;	
	String rider_account;	
	String rider_loc;	
	String rider_type;
}
 