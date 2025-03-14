package com.prosperllc.repository;

import com.prosperllc.model.ServiceInfo;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ServiceInfoRepository extends MongoRepository<ServiceInfo, String> {
}
