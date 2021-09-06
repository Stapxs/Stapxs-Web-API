package cn.stapxs.api.service.impl;

import cn.stapxs.api.domain.msg.AnaMsg;
import cn.stapxs.api.service.AnaService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * @Version: 1.0
 * @Date: 2021/9/1 下午 4:35
 * @ClassName: AnaServiceImpl
 * @Author: Stapxs
 * @Description TO DO
 **/
@Service
@Transactional
public class AnaServiceImpl implements AnaService {

    @Override
    public AnaMsg getAna(String file) {
        List<String> ana = readAna(file);
        if(ana.get(0).equals("err")) {
            return null;
        }
        Random random = new Random();
        return getAna(file, random.nextInt(ana.size()));
    }

    @Override
    public AnaMsg getAna(String file, int index) {
        List<String> ana = readAna(file);
        if(ana.get(0).equals("err") || index > ana.size()) {
            return null;
        }
        AnaMsg anaRet = new AnaMsg();
        anaRet.setStatus(200);
        anaRet.setMessage("OK");
        anaRet.setAna(ana.get(index).split("/")[1]);
        anaRet.setId(index);
        anaRet.setTime(ana.get(index).split("/")[0]);
        return anaRet;
    }

    // ------------------------------------------------------------

    private List<String> readAna(String file) {
        List<String> back = new ArrayList<>();
        try {
            File filename = new File(file);
            InputStreamReader reader = new InputStreamReader(
                    new FileInputStream(filename));
            BufferedReader br = new BufferedReader(reader);
            String line = "";
            line = br.readLine();
            back.add(line);
            while (line != null) {
                line = br.readLine();
                back.add(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
            back = new ArrayList<>();
            back.add("err");
            return back;
        }
        return back;
    }
}
