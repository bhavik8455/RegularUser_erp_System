package operations.reguser;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.RegPojo;

public class RegisterImplementation  implements RegisterInterface {

	@Override
	public String registerUser(RegPojo pojo) {
		String result = null;
		try {
			CallableStatement callableStatement = db.GetConnection.getConnection().prepareCall("CALL demo_erp.Registration(?,?,?,?)");
			callableStatement.setString(1, pojo.getMail());
			callableStatement.setString(2, pojo.getName());
			callableStatement.setString(3, pojo.getPword());
			callableStatement.setString(4, pojo.getRole());
			
			ResultSet rs = callableStatement.executeQuery();
			
			if(rs.next()) {
				
				 result = rs.getString(1);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	

}
