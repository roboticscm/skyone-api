package vn.com.sky;

import java.util.Arrays;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;

@Configuration
public class SwaggerConfig {
    @Bean
    public OpenAPI customOpenAPI() {
      return new OpenAPI()
              .components(new Components().addSecuritySchemes("bearer-jwt",
               new SecurityScheme().type(SecurityScheme.Type.HTTP).scheme("bearer").bearerFormat("JWT")
              .in(SecurityScheme.In.HEADER).name("Authorization")))
              .info(new Info().title("SkyPlus API").description("OpenAPI 3.0")
                    .contact(new Contact().email("roboticscm2018@gmail.com").name("khailv").url("https://suntech.com.vn"))
                    .license(
                            new License().name("Apache 2.0").url("http://www.apache.org/licenses/LICENSE-2.0.html"))
                    .version("1.0.0"))
              .addSecurityItem(
                      new SecurityRequirement().addList("bearer-jwt", Arrays.asList("read", "write")));
    }
}
