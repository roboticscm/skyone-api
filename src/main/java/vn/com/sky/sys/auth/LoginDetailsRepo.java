/**
 *
 */
package vn.com.sky.sys.auth;

import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Service;

/**
 * @author roboticscm2018@gmail.com (khai.lv)
 * Created date: Apr 17, 2019
 */
@Service
public interface LoginDetailsRepo extends ReactiveCrudRepository<LoginDetails, Object> {}
