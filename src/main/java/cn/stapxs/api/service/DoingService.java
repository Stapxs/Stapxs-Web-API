package cn.stapxs.api.service;

import cn.stapxs.api.domain.tool.DoingMsg;

import java.util.Optional;

public interface DoingService {

    public String verifyKey(int id, String key, String use);

    public boolean saveDoing(int id, String json);
    public DoingMsg[] getDoing(int id);
}
