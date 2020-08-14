package vn.com.sky.sys.auth;

import org.springframework.data.repository.reactive.ReactiveCrudRepository;
import org.springframework.stereotype.Service;
import vn.com.sky.sys.model.AuthToken;

@Service
public interface AuthTokenRepo extends ReactiveCrudRepository<AuthToken, Long> {}
